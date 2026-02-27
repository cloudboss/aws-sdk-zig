pub const MaxEventSize = enum {
    standard,
    large,

    pub const json_field_names = .{
        .standard = "Standard",
        .large = "Large",
    };
};
