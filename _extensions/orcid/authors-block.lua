--[[
authors-block – affiliations block extension for quarto

Copyright (c) 2023 Lorenz A. Kapsner

Permission to use, copy, modify, and/or distribute this software for any purpose
with or without fee is hereby granted, provided that the above copyright notice
and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
THIS SOFTWARE.
]]

local List = require 'pandoc.List'

-- [import]
local from_utils = require "utils"
local normalize_affiliations = from_utils.normalize_affiliations
local normalize_authors = from_utils.normalize_authors
local normalize_latex_authors = from_utils.normalize_latex_authors

local from_authors = require "from_author_info_blocks"
local default_marks = from_authors.default_marks
local create_equal_contributors_block = from_authors.create_equal_contributors_block
local create_affiliations_blocks = from_authors.create_affiliations_blocks
local create_correspondence_blocks = from_authors.create_correspondence_blocks
local is_corresponding_author = from_authors.is_corresponding_author
local author_inline_generator = from_authors.author_inline_generator
local create_authors_inlines = from_authors.create_authors_inlines
-- [/import]

-- This is the main-part
function Pandoc(doc)
  local meta = doc.meta
  local blocks = List:new{}

  local mark = function (mark_name) return default_marks[mark_name] end

  blocks:extend(create_equal_contributors_block(meta.authors, mark) or {})
  blocks:extend(create_affiliations_blocks(meta.affiliations) or {})
  blocks:extend(create_correspondence_blocks(meta.authors, mark) or {})

  -- expose as metadata so the template can place it
  meta["authors-block"] = pandoc.MetaBlocks(blocks)

  -- (keep your existing normalization code)
  for _i, author in ipairs(meta.authors) do
    author.test = is_corresponding_author(author)
  end
  meta.affiliations = normalize_affiliations(meta.affiliations)
  meta.author = meta.authors:map(normalize_authors(meta.affiliations))
  meta.author = pandoc.MetaInlines(create_authors_inlines(meta.author, mark))
  meta.affiliations = nil

  return pandoc.Pandoc(doc.blocks, meta)
end
