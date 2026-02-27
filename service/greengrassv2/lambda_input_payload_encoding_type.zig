pub const LambdaInputPayloadEncodingType = enum {
    json,
    binary,

    pub const json_field_names = .{
        .json = "JSON",
        .binary = "BINARY",
    };
};
