const BlockType = @import("block_type.zig").BlockType;
const EntityType = @import("entity_type.zig").EntityType;
const Geometry = @import("geometry.zig").Geometry;
const Query = @import("query.zig").Query;
const Relationship = @import("relationship.zig").Relationship;
const SelectionStatus = @import("selection_status.zig").SelectionStatus;
const TextType = @import("text_type.zig").TextType;

/// A `Block` represents items that are recognized in a document within a group
/// of pixels close to each other. The information returned in a `Block` object
/// depends on the type of operation. In text detection for documents (for
/// example DetectDocumentText), you get information about the detected words
/// and lines
/// of text. In text analysis (for example AnalyzeDocument), you can also get
/// information about the fields, tables, and selection elements that are
/// detected in the
/// document.
///
/// An array of `Block` objects is returned by both synchronous and asynchronous
/// operations. In synchronous operations, such as DetectDocumentText, the
/// array of `Block` objects is the entire set of results. In asynchronous
/// operations, such as GetDocumentAnalysis, the array is returned over one
/// or more responses.
///
/// For more information, see [How Amazon Textract
/// Works](https://docs.aws.amazon.com/textract/latest/dg/how-it-works.html).
pub const Block = struct {
    /// The type of text item that's recognized. In operations for text detection,
    /// the following
    /// types are returned:
    ///
    /// * *PAGE* - Contains a list of the LINE `Block` objects
    /// that are detected on a document page.
    ///
    /// * *WORD* - A word detected on a document page. A word is one or
    /// more ISO basic Latin script characters that aren't separated by spaces.
    ///
    /// * *LINE* - A string of space-delimited, contiguous words that are
    /// detected on a document page.
    ///
    /// In text analysis operations, the following types are returned:
    ///
    /// * *PAGE* - Contains a list of child `Block` objects
    /// that are detected on a document page.
    ///
    /// * *KEY_VALUE_SET* - Stores the KEY and VALUE `Block`
    /// objects for linked text that's detected on a document page. Use the
    /// `EntityType` field to determine if a KEY_VALUE_SET object is a KEY
    /// `Block` object or a VALUE `Block` object.
    ///
    /// * *WORD* - A word that's detected on a document page. A word is
    /// one or more ISO basic Latin script characters that aren't separated by
    /// spaces.
    ///
    /// * *LINE* - A string of tab-delimited, contiguous words that are
    /// detected on a document page.
    ///
    /// * *TABLE* - A table that's detected on a document page. A table
    /// is grid-based information with two or more rows or columns, with a cell span
    /// of one
    /// row and one column each.
    ///
    /// * *TABLE_TITLE* - The title of a table. A title is typically a
    /// line of text above or below a table, or embedded as the first row of a
    /// table.
    ///
    /// * *TABLE_FOOTER* - The footer associated with a table. A footer
    /// is typically a line or lines of text below a table or embedded as the last
    /// row of a
    /// table.
    ///
    /// * *CELL* - A cell within a detected table. The cell is the parent
    /// of the block that contains the text in the cell.
    ///
    /// * *MERGED_CELL* - A cell in a table whose content spans more than
    /// one row or column. The `Relationships` array for this cell contain data
    /// from individual cells.
    ///
    /// * *SELECTION_ELEMENT* - A selection element such as an option
    /// button (radio button) or a check box that's detected on a document page. Use
    /// the
    /// value of `SelectionStatus` to determine the status of the selection
    /// element.
    ///
    /// * *SIGNATURE* - The location and confidence score of a signature detected on
    ///   a
    /// document page. Can be returned as part of a Key-Value pair or a detected
    /// cell.
    ///
    /// * *QUERY* - A question asked during the call of AnalyzeDocument. Contains an
    /// alias and an ID that attaches it to its answer.
    ///
    /// * *QUERY_RESULT* - A response to a question asked during the call
    /// of analyze document. Comes with an alias and ID for ease of locating in a
    /// response. Also contains location and confidence score.
    ///
    /// The following BlockTypes are only returned for Amazon Textract Layout.
    ///
    /// * `LAYOUT_TITLE` - The main title of the document.
    ///
    /// * `LAYOUT_HEADER` - Text located in the top margin of the document.
    ///
    /// * `LAYOUT_FOOTER` - Text located in the bottom margin of the document.
    ///
    /// * `LAYOUT_SECTION_HEADER` - The titles of sections within a document.
    ///
    /// * `LAYOUT_PAGE_NUMBER` - The page number of the documents.
    ///
    /// * `LAYOUT_LIST` - Any information grouped together in list form.
    ///
    /// * `LAYOUT_FIGURE` - Indicates the location of an image in a document.
    ///
    /// * `LAYOUT_TABLE` - Indicates the location of a table in the document.
    ///
    /// * `LAYOUT_KEY_VALUE` - Indicates the location of form key-values in a
    ///   document.
    ///
    /// * `LAYOUT_TEXT` - Text that is present typically as a part of paragraphs in
    ///   documents.
    block_type: ?BlockType = null,

    /// The column in which a table cell appears. The first column position is 1.
    /// `ColumnIndex` isn't returned by `DetectDocumentText` and
    /// `GetDocumentTextDetection`.
    column_index: ?i32 = null,

    /// The number of columns that a table cell spans. `ColumnSpan` isn't returned
    /// by
    /// `DetectDocumentText` and `GetDocumentTextDetection`.
    column_span: ?i32 = null,

    /// The confidence score that Amazon Textract has in the accuracy of the
    /// recognized text and
    /// the accuracy of the geometry points around the recognized text.
    confidence: ?f32 = null,

    /// The type of entity.
    ///
    /// The following entity types can be returned by FORMS analysis:
    ///
    /// * *KEY* - An identifier for a field on the document.
    ///
    /// * *VALUE* - The field text.
    ///
    /// The following entity types can be returned by TABLES analysis:
    ///
    /// * *COLUMN_HEADER* - Identifies a cell that is a header of a column.
    ///
    /// * *TABLE_TITLE* - Identifies a cell that is a title within the
    /// table.
    ///
    /// * *TABLE_SECTION_TITLE* - Identifies a cell that is a title of a
    /// section within a table. A section title is a cell that typically spans an
    /// entire row
    /// above a section.
    ///
    /// * *TABLE_FOOTER* - Identifies a cell that is a footer of a table.
    ///
    /// * *TABLE_SUMMARY* - Identifies a summary cell of a table. A
    /// summary cell can be a row of a table or an additional, smaller table that
    /// contains
    /// summary information for another table.
    ///
    /// * *STRUCTURED_TABLE * - Identifies a table with column headers
    /// where the content of each row corresponds to the headers.
    ///
    /// * *SEMI_STRUCTURED_TABLE* - Identifies a non-structured table.
    ///
    /// `EntityTypes` isn't returned by `DetectDocumentText` and
    /// `GetDocumentTextDetection`.
    entity_types: ?[]const EntityType = null,

    /// The location of the recognized text on the image. It includes an
    /// axis-aligned, coarse
    /// bounding box that surrounds the text, and a finer-grain polygon for more
    /// accurate spatial
    /// information.
    geometry: ?Geometry = null,

    /// The identifier for the recognized text. The identifier is only unique for a
    /// single
    /// operation.
    id: ?[]const u8 = null,

    /// The page on which a block was detected. `Page` is returned by synchronous
    /// and
    /// asynchronous operations. Page values greater than 1 are only returned for
    /// multipage
    /// documents that are in PDF or TIFF format. A scanned image (JPEG/PNG)
    /// provided to an
    /// asynchronous operation, even if it contains multiple document pages, is
    /// considered a
    /// single-page document. This means that for scanned images the value of `Page`
    /// is
    /// always 1.
    page: ?i32 = null,

    query: ?Query = null,

    /// A list of relationship objects that describe how blocks are related to each
    /// other. For
    /// example, a LINE block object contains a CHILD relationship type with the
    /// WORD blocks that
    /// make up the line of text. There aren't Relationship objects in the list for
    /// relationships
    /// that don't exist, such as when the current block has no child blocks.
    relationships: ?[]const Relationship = null,

    /// The row in which a table cell is located. The first row position is 1.
    /// `RowIndex` isn't returned by `DetectDocumentText` and
    /// `GetDocumentTextDetection`.
    row_index: ?i32 = null,

    /// The number of rows that a table cell spans. `RowSpan` isn't returned by
    /// `DetectDocumentText` and `GetDocumentTextDetection`.
    row_span: ?i32 = null,

    /// The selection status of a selection element, such as an option button or
    /// check box.
    selection_status: ?SelectionStatus = null,

    /// The word or line of text that's recognized by Amazon Textract.
    text: ?[]const u8 = null,

    /// The kind of text that Amazon Textract has detected. Can check for
    /// handwritten text and
    /// printed text.
    text_type: ?TextType = null,

    pub const json_field_names = .{
        .block_type = "BlockType",
        .column_index = "ColumnIndex",
        .column_span = "ColumnSpan",
        .confidence = "Confidence",
        .entity_types = "EntityTypes",
        .geometry = "Geometry",
        .id = "Id",
        .page = "Page",
        .query = "Query",
        .relationships = "Relationships",
        .row_index = "RowIndex",
        .row_span = "RowSpan",
        .selection_status = "SelectionStatus",
        .text = "Text",
        .text_type = "TextType",
    };
};
