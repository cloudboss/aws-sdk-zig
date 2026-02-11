pub const FullDocument = enum {
    update_lookup,
    default,

    pub const json_field_names = .{
        .update_lookup = "UpdateLookup",
        .default = "Default",
    };
};
