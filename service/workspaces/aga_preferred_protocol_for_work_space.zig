pub const AGAPreferredProtocolForWorkSpace = enum {
    tcp,
    none,
    inherited,

    pub const json_field_names = .{
        .tcp = "TCP",
        .none = "NONE",
        .inherited = "INHERITED",
    };
};
