const ColumnWildcard = @import("column_wildcard.zig").ColumnWildcard;

/// A structure for a table with columns object. This object is only used when
/// granting a SELECT permission.
///
/// This object must take a value for at least one of `ColumnsNames`,
/// `ColumnsIndexes`, or `ColumnsWildcard`.
pub const TableWithColumnsResource = struct {
    /// The identifier for the Data Catalog. By default, it is the account ID of the
    /// caller.
    catalog_id: ?[]const u8 = null,

    /// The list of column names for the table. At least one of `ColumnNames` or
    /// `ColumnWildcard` is required.
    column_names: ?[]const []const u8 = null,

    /// A wildcard specified by a `ColumnWildcard` object. At least one of
    /// `ColumnNames` or `ColumnWildcard` is required.
    column_wildcard: ?ColumnWildcard = null,

    /// The name of the database for the table with columns resource. Unique to the
    /// Data Catalog. A database is a set of associated table definitions organized
    /// into a logical group. You can Grant and Revoke database privileges to a
    /// principal.
    database_name: []const u8,

    /// The name of the table resource. A table is a metadata definition that
    /// represents your data. You can Grant and Revoke table privileges to a
    /// principal.
    name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .column_names = "ColumnNames",
        .column_wildcard = "ColumnWildcard",
        .database_name = "DatabaseName",
        .name = "Name",
    };
};
