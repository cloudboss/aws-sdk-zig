pub const RedshiftQueryEngineType = enum {
    serverless,
    provisioned,

    pub const json_field_names = .{
        .serverless = "SERVERLESS",
        .provisioned = "PROVISIONED",
    };
};
