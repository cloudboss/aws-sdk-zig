/// Data type of a column.
pub const ColumnDataType = enum {
    string,
    char,
    integer,
    tinyint,
    smallint,
    bigint,
    float,
    double,
    date,
    datetime,
    boolean,
    binary,

    pub const json_field_names = .{
        .string = "STRING",
        .char = "CHAR",
        .integer = "INTEGER",
        .tinyint = "TINYINT",
        .smallint = "SMALLINT",
        .bigint = "BIGINT",
        .float = "FLOAT",
        .double = "DOUBLE",
        .date = "DATE",
        .datetime = "DATETIME",
        .boolean = "BOOLEAN",
        .binary = "BINARY",
    };
};
