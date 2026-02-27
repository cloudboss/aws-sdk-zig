pub const ModelEndpointStatus = enum {
    associated,
    dissociated,

    pub const json_field_names = .{
        .associated = "ASSOCIATED",
        .dissociated = "DISSOCIATED",
    };
};
