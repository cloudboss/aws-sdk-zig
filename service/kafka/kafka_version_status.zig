pub const KafkaVersionStatus = enum {
    active,
    deprecated,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deprecated = "DEPRECATED",
    };
};
