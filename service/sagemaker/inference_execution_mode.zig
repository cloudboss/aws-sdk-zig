pub const InferenceExecutionMode = enum {
    serial,
    direct,

    pub const json_field_names = .{
        .serial = "SERIAL",
        .direct = "DIRECT",
    };
};
