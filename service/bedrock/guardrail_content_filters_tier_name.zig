pub const GuardrailContentFiltersTierName = enum {
    classic,
    standard,

    pub const json_field_names = .{
        .classic = "CLASSIC",
        .standard = "STANDARD",
    };
};
