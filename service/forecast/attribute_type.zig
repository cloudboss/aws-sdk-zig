pub const AttributeType = enum {
    string,
    integer,
    float,
    timestamp,
    geolocation,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .float = "FLOAT",
        .timestamp = "TIMESTAMP",
        .geolocation = "GEOLOCATION",
    };
};
