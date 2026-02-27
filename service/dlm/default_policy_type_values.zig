pub const DefaultPolicyTypeValues = enum {
    volume,
    instance,

    pub const json_field_names = .{
        .volume = "VOLUME",
        .instance = "INSTANCE",
    };
};
