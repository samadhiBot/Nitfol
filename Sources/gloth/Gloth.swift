//
//  Gloth.swift
//  Gloth
//
//  Created by Chris Sessions on 2/5/22.
//

import CoreML
import CreateML
import Files

enum Gloth {
    static func run() throws {
        let artifacts = try artifacts()

        let trainingData = try artifacts.createFile(named: "training-data.json")
        let testingData = try artifacts.createFile(named: "testing-data.json")
        let validationData = try artifacts.createFile(named: "validation-data.json")

        for file in [trainingData, testingData, validationData] {
            try file.write(phrasesJSON(
                Attack.generate(200),
                Go.generate(200)
            ))
            print("Created data file \(file.path)")
        }

        try generateModel(
            trainingDataURL: trainingData.url,
            testingDataURL: testingData.url,
            destination: artifacts
        )
    }
}

// MARK: - Private helpers

private extension Gloth {
    static func artifacts() throws -> Folder {
        if let oldArtifacts = try? Folder.current.subfolder(named: "Artifacts") {
            try oldArtifacts.delete()
        }
        let artifacts = try Folder.current.createSubfolder(named: "Artifacts")
        let package = try artifacts.createFile(named: "Package.swift")
        try package.write(
            """
            // swift-tools-version:5.3
            import PackageDescription
            // This package exists to prevent Xcode from displaying the Artifacts folder.
            let package = Package(name: "Artifacts", products: [], targets: [])
            """
        )
        return artifacts
    }

    static func generateModel(
        trainingDataURL: URL,
        testingDataURL: URL,
        destination: Folder
    ) throws {
        let trainingDataTable = try MLDataTable(contentsOf: trainingDataURL)
        let wordTagger = try MLWordTagger(
            trainingData: trainingDataTable,
            tokenColumn: "tokens",
            labelColumn: "labels"
        )

        let testingDataTable = try MLDataTable(contentsOf: testingDataURL)

        let trainingAccuracy = (1.0 - wordTagger.trainingMetrics.taggingError) * 100
        print("\nTraining Accuracy: \(trainingAccuracy)%")

        let validationAccuracy = (1.0 - wordTagger.validationMetrics.taggingError) * 100
        print("\nValidation Accuracy: \(validationAccuracy)%")

        let evaluationMetrics = wordTagger.evaluation(
            on: testingDataTable,
            tokenColumn: "tokens",
            labelColumn: "labels"
        )
        let evaluationAccuracy = (1.0 - evaluationMetrics.taggingError) * 100
        print("\nEvaluation Accuracy: \(evaluationAccuracy)%")

        let confusionMatrix = evaluationMetrics.confusion
        print("\nConfusion Matrix:", confusionMatrix)

        let metadata = MLModelMetadata(
            author: "Gloth",
            shortDescription: "Generates a CoreML Word Tagger Model trained on interactive fiction commands.",
            version: "0.1"
        )
        let mlModel = try destination.createFile(named: "Gloth.mlmodel")
        try wordTagger.write(to: mlModel.url, metadata: metadata)

        let compiledURL = try MLModel.compileModel(at: mlModel.url)
        let compiledModel = try Folder(path: compiledURL.path)
        try compiledModel.move(to: destination)
        try compiledModel.rename(to: "Gloth.mlmodelc")
        print("\nCompiled model successfully saved at \(compiledModel.path)")
    }

    static func phrasesJSON(_ phraseSets: [Phrase]...) -> String {
        let phrases = phraseSets.reduce(into: []) { result, phraseSet in
            result += phraseSet
        }
        let json = phrases
            .sorted()
            .map({ $0.toJSON }).joined(separator: ",\n    ")
        return """
            [
                \(json)
            ]
            """
    }
}
