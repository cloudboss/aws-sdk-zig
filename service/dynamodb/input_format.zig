pub const InputFormat = enum {
    dynamodb_json,
    ion,
    csv,

    pub const json_field_names = .{
        .dynamodb_json = "DYNAMODB_JSON",
        .ion = "ION",
        .csv = "CSV",
    };
};
