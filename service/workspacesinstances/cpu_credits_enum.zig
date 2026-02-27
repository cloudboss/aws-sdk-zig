pub const CpuCreditsEnum = enum {
    standard,
    unlimited,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .unlimited = "UNLIMITED",
    };
};
