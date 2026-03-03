const BlockType = @import("block_type.zig").BlockType;
const Geometry = @import("geometry.zig").Geometry;
const RelationshipsListItem = @import("relationships_list_item.zig").RelationshipsListItem;

/// Information about each word or line of text in the input document.
///
/// For additional information, see
/// [Block](https://docs.aws.amazon.com/textract/latest/dg/API_Block.html) in
/// the Amazon Textract API reference.
pub const Block = struct {
    /// The block represents a line of text or one word of text.
    ///
    /// * WORD - A word that's detected on a document page.
    /// A word is one or more ISO basic Latin script characters that aren't
    /// separated by spaces.
    ///
    /// * LINE - A string of tab-delimited, contiguous words
    /// that are detected on a document page
    block_type: ?BlockType = null,

    /// Co-ordinates of the rectangle or polygon that contains the text.
    geometry: ?Geometry = null,

    /// Unique identifier for the block.
    id: ?[]const u8 = null,

    /// Page number where the block appears.
    page: ?i32 = null,

    /// A list of child blocks of the current block.
    /// For example, a LINE object has child blocks for each WORD block that's part
    /// of the line of text.
    relationships: ?[]const RelationshipsListItem = null,

    /// The word or line of text extracted from the block.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .block_type = "BlockType",
        .geometry = "Geometry",
        .id = "Id",
        .page = "Page",
        .relationships = "Relationships",
        .text = "Text",
    };
};
