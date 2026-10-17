const Column = @import("column.zig").Column;

/// A structure that describes a row-level security policy, including the
/// columns its filter expression references and the filter expression itself.
pub const RLSPolicy = struct {
    /// The list of columns that the filter expression references.
    attachment_columns: ?[]const Column = null,

    /// The identifier for the Data Catalog that contains the policy. By default,
    /// the account ID.
    catalog_id: ?[]const u8 = null,

    /// The filter predicate, written in a SQL-like syntax, that determines which
    /// rows are returned to the principal.
    filter_expression: ?[]const u8 = null,

    /// The name of the row-level security policy.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment_columns = "AttachmentColumns",
        .catalog_id = "CatalogId",
        .filter_expression = "FilterExpression",
        .name = "Name",
    };
};
