pub const BundleType = enum {
    regular,
    standby,

    pub const json_field_names = .{
        .regular = "REGULAR",
        .standby = "STANDBY",
    };
};
