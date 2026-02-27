/// Contains the metadata for a column.
pub const ColumnMetadata = struct {
    /// The type of the column.
    array_base_column_type: i32 = 0,

    /// A value that indicates whether the column increments automatically.
    is_auto_increment: bool = false,

    /// A value that indicates whether the column is case-sensitive.
    is_case_sensitive: bool = false,

    /// A value that indicates whether the column contains currency values.
    is_currency: bool = false,

    /// A value that indicates whether an integer column is signed.
    is_signed: bool = false,

    /// The label for the column.
    label: ?[]const u8,

    /// The name of the column.
    name: ?[]const u8,

    /// A value that indicates whether the column is nullable.
    nullable: i32 = 0,

    /// The precision value of a decimal number column.
    precision: i32 = 0,

    /// The scale value of a decimal number column.
    scale: i32 = 0,

    /// The name of the schema that owns the table that includes the column.
    schema_name: ?[]const u8,

    /// The name of the table that includes the column.
    table_name: ?[]const u8,

    /// The type of the column.
    type: i32 = 0,

    /// The database-specific data type of the column.
    type_name: ?[]const u8,

    pub const json_field_names = .{
        .array_base_column_type = "arrayBaseColumnType",
        .is_auto_increment = "isAutoIncrement",
        .is_case_sensitive = "isCaseSensitive",
        .is_currency = "isCurrency",
        .is_signed = "isSigned",
        .label = "label",
        .name = "name",
        .nullable = "nullable",
        .precision = "precision",
        .scale = "scale",
        .schema_name = "schemaName",
        .table_name = "tableName",
        .type = "type",
        .type_name = "typeName",
    };
};
