const AdditionalNotes = @import("additional_notes.zig").AdditionalNotes;
const ColumnDescription = @import("column_description.zig").ColumnDescription;
const ColumnSemanticType = @import("column_semantic_type.zig").ColumnSemanticType;

/// A semantic property for a column.
pub const ColumnSemanticProperty = struct {
    /// Additional notes for the column.
    additional_notes: ?AdditionalNotes = null,

    /// A description of the column.
    description: ?ColumnDescription = null,

    /// The semantic type of the column.
    semantic_type: ?ColumnSemanticType = null,

    pub const json_field_names = .{
        .additional_notes = "AdditionalNotes",
        .description = "Description",
        .semantic_type = "SemanticType",
    };
};
