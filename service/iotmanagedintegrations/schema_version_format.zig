pub const SchemaVersionFormat = enum {
    aws,
    zcl,
    connector,

    pub const json_field_names = .{
        .aws = "AWS",
        .zcl = "ZCL",
        .connector = "CONNECTOR",
    };
};
