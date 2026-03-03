const ColumnNullable = @import("column_nullable.zig").ColumnNullable;

/// Information about the columns in a query execution result.
pub const ColumnInfo = struct {
    /// Indicates whether values in the column are case-sensitive.
    case_sensitive: bool = false,

    /// The catalog to which the query results belong.
    catalog_name: ?[]const u8 = null,

    /// A column label.
    label: ?[]const u8 = null,

    /// The name of the column.
    name: []const u8,

    /// Unsupported constraint. This value always shows as `UNKNOWN`.
    nullable: ?ColumnNullable = null,

    /// For `DECIMAL` data types, specifies the total number of digits, up to 38.
    /// For performance reasons, we recommend up to 18 digits.
    precision: i32 = 0,

    /// For `DECIMAL` data types, specifies the total number of digits in the
    /// fractional part of the value. Defaults to 0.
    scale: i32 = 0,

    /// The schema name (database name) to which the query results belong.
    schema_name: ?[]const u8 = null,

    /// The table name for the query results.
    table_name: ?[]const u8 = null,

    /// The data type of the column.
    @"type": []const u8,

    pub const json_field_names = .{
        .case_sensitive = "CaseSensitive",
        .catalog_name = "CatalogName",
        .label = "Label",
        .name = "Name",
        .nullable = "Nullable",
        .precision = "Precision",
        .scale = "Scale",
        .schema_name = "SchemaName",
        .table_name = "TableName",
        .@"type" = "Type",
    };
};
