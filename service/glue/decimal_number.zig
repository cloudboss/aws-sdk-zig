/// Contains a numeric value in decimal format.
pub const DecimalNumber = struct {
    /// The scale that determines where the decimal point falls in the
    /// unscaled value.
    scale: i32 = 0,

    /// The unscaled numeric value.
    unscaled_value: []const u8,

    pub const json_field_names = .{
        .scale = "Scale",
        .unscaled_value = "UnscaledValue",
    };
};
