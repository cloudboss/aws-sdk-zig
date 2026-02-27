/// Burn In Alignment
pub const BurnInAlignment = enum {
    centered,
    left,
    smart,

    pub const json_field_names = .{
        .centered = "CENTERED",
        .left = "LEFT",
        .smart = "SMART",
    };
};
