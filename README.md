# Nitfol

> Nitfol: Converse with beasts in their own tongue

A CoreML-based Natural Language Parser trained to understand interactive fiction commands.

---

## Gloth

> Gloth: Fold dough 83 times

Nitfol includes the `gloth` tool, which generates training data based on interactive fiction commands. It uses this to create a word tagger model for use with Nitfol.

Running `swift run gloth` from the Nitfol project root creates an `Artifacts` directory, containing the generated testing and training data, and the resulting word tagging model. As `gloth` generates the model, it logs training, validation and evaluation accuracy, and displays a confusion matrix.

When you're satisfied with the `Gloth.mlmodel` results, you can drag the compiled `Gloth.mlmodelc` into the `Sources/Nitfol/Resources` directory for use in Nitfol.

### Reference

See [Creating a Word Tagger Model](https://developer.apple.com/documentation/createml/creating_a_word_tagger_model).
