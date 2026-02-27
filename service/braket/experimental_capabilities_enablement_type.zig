pub const ExperimentalCapabilitiesEnablementType = enum {
    all,
    none,

    pub const json_field_names = .{
        .all = "ALL",
        .none = "NONE",
    };
};
