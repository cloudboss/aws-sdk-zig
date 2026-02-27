pub const PipelineType = enum {
    v1,
    v2,

    pub const json_field_names = .{
        .v1 = "V1",
        .v2 = "V2",
    };
};
