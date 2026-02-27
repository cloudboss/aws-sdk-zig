pub const NodeCategory = enum {
    business_logic,
    ml_model,
    media_source,
    media_sink,

    pub const json_field_names = .{
        .business_logic = "BUSINESS_LOGIC",
        .ml_model = "ML_MODEL",
        .media_source = "MEDIA_SOURCE",
        .media_sink = "MEDIA_SINK",
    };
};
