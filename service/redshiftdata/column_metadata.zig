/// The properties (metadata) of a column.
pub const ColumnMetadata = struct {
    /// The default value of the column.
    column_default: ?[]const u8 = null,

    /// A value that indicates whether the column is case-sensitive.
    is_case_sensitive: bool = false,

    /// A value that indicates whether the column contains currency values.
    is_currency: bool = false,

    /// A value that indicates whether an integer column is signed.
    is_signed: bool = false,

    /// The label for the column.
    label: ?[]const u8 = null,

    /// The length of the column.
    length: i32 = 0,

    /// The name of the column.
    name: ?[]const u8 = null,

    /// A value that indicates whether the column is nullable.
    nullable: i32 = 0,

    /// The precision value of a decimal number column.
    precision: i32 = 0,

    /// The scale value of a decimal number column.
    scale: i32 = 0,

    /// The name of the schema that contains the table that includes the column.
    schema_name: ?[]const u8 = null,

    /// The name of the table that includes the column.
    table_name: ?[]const u8 = null,

    /// The database-specific data type of the column.
    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_default = "columnDefault",
        .is_case_sensitive = "isCaseSensitive",
        .is_currency = "isCurrency",
        .is_signed = "isSigned",
        .label = "label",
        .length = "length",
        .name = "name",
        .nullable = "nullable",
        .precision = "precision",
        .scale = "scale",
        .schema_name = "schemaName",
        .table_name = "tableName",
        .type_name = "typeName",
    };
};
