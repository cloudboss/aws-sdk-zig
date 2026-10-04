const ColumnSemanticProperty = @import("column_semantic_property.zig").ColumnSemanticProperty;

/// Semantic metadata shared across one or more columns.
pub const SharedColumnSemanticMetadata = struct {
    /// The names of the columns this metadata applies to.
    column_names: ?[]const []const u8 = null,

    /// The semantic properties for the specified columns.
    column_properties: []const ColumnSemanticProperty,

    pub const json_field_names = .{
        .column_names = "ColumnNames",
        .column_properties = "ColumnProperties",
    };
};
