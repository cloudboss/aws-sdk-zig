const ColumnWildcard = @import("column_wildcard.zig").ColumnWildcard;
const RowFilter = @import("row_filter.zig").RowFilter;

/// A structure that describes certain columns on certain rows.
pub const DataCellsFilter = struct {
    /// A list of column names and/or nested column attributes. When specifying
    /// nested attributes, use a qualified dot (.) delimited format such as
    /// "address"."zip". Nested attributes within this list may not exceed a depth
    /// of 5.
    column_names: ?[]const []const u8 = null,

    /// A wildcard with exclusions.
    ///
    /// You must specify either a `ColumnNames` list or the
    /// `ColumnWildCard`.
    column_wildcard: ?ColumnWildcard = null,

    /// A database in the Glue Data Catalog.
    database_name: []const u8,

    /// The name given by the user to the data filter cell.
    name: []const u8,

    /// A PartiQL predicate.
    row_filter: ?RowFilter = null,

    /// The ID of the catalog to which the table belongs.
    table_catalog_id: []const u8,

    /// A table in the database.
    table_name: []const u8,

    /// The ID of the data cells filter version.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_names = "ColumnNames",
        .column_wildcard = "ColumnWildcard",
        .database_name = "DatabaseName",
        .name = "Name",
        .row_filter = "RowFilter",
        .table_catalog_id = "TableCatalogId",
        .table_name = "TableName",
        .version_id = "VersionId",
    };
};
