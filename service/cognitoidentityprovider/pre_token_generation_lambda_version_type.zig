pub const PreTokenGenerationLambdaVersionType = enum {
    v1_0,
    v2_0,
    v3_0,

    pub const json_field_names = .{
        .v1_0 = "V1_0",
        .v2_0 = "V2_0",
        .v3_0 = "V3_0",
    };
};
