# Orcid Format


## Installing

You can install this extension in two ways:

**Option 1: Use as a template (creates an example qmd file):**

```bash
quarto use template kv9898/orcid
```

**Option 2: Add as a project extension (does not create example file):**

```bash
quarto add kv9898/orcid
```

Both methods will install the extension. The `use` command also creates an example qmd file you can use as a starting place for your article.

## Using

This project builds on [kasper/authors-block](https://github.com/kapsner/authors-block) and add the orcid, keywords, cover page and refined toc features to the pdf format. Note that new features only work for pdf documents.

## Format Options

Essentially the same as [kasper/authors-block](https://github.com/kapsner/authors-block), just that orcid numbers will be displayed through logos with hyperlinks and keywords for the pdf format.

## Example

Here is the source code for a minimal sample document: [example.qmd](example.qmd).

The compiled pdf looks like this:

![](example.png)

## Additional YAML Options

- `header`: Type the header you want to display from second page onward.
- `toc-newpage`: Can be `true` or `false`, indicating whether or not you want a new page for the table of contents, given that `toc: true`.
- `acknowledgements`: Type the acknowledgements you want to display as an unnumbered footnote.
