pub const ExportFormat = enum {
    dynamodb_json,
    ion,

    pub const json_field_names = .{
        .dynamodb_json = "DYNAMODB_JSON",
        .ion = "ION",
    };
};
