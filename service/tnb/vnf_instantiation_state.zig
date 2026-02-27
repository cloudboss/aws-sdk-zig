pub const VnfInstantiationState = enum {
    instantiated,
    not_instantiated,

    pub const json_field_names = .{
        .instantiated = "INSTANTIATED",
        .not_instantiated = "NOT_INSTANTIATED",
    };
};
