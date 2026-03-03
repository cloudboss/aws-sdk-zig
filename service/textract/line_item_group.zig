const LineItemFields = @import("line_item_fields.zig").LineItemFields;

/// A grouping of tables which contain LineItems, with each table identified by
/// the table's `LineItemGroupIndex`.
pub const LineItemGroup = struct {
    /// The number used to identify a specific table in a document. The first table
    /// encountered will have a LineItemGroupIndex of 1, the second 2, etc.
    line_item_group_index: ?i32 = null,

    /// The breakdown of information on a particular line of a table.
    line_items: ?[]const LineItemFields = null,

    pub const json_field_names = .{
        .line_item_group_index = "LineItemGroupIndex",
        .line_items = "LineItems",
    };
};
