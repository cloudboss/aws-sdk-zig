pub const AGAPreferredProtocolForDirectory = enum {
    tcp,
    none,

    pub const json_field_names = .{
        .tcp = "TCP",
        .none = "NONE",
    };
};
