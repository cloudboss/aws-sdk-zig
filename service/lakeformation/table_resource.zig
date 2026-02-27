const TableWildcard = @import("table_wildcard.zig").TableWildcard;

/// A structure for the table object. A table is a metadata definition that
/// represents your data. You can Grant and Revoke table privileges to a
/// principal.
pub const TableResource = struct {
    /// The identifier for the Data Catalog. By default, it is the account ID of the
    /// caller.
    catalog_id: ?[]const u8,

    /// The name of the database for the table. Unique to a Data Catalog. A database
    /// is a set of associated table definitions organized into a logical group. You
    /// can Grant and Revoke database privileges to a principal.
    database_name: []const u8,

    /// The name of the table.
    name: ?[]const u8,

    /// A wildcard object representing every table under a database.
    ///
    /// At least one of `TableResource$Name` or `TableResource$TableWildcard` is
    /// required.
    table_wildcard: ?TableWildcard,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .name = "Name",
        .table_wildcard = "TableWildcard",
    };
};
