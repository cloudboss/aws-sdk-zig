/// Settings for a noise reducer filter
pub const NoiseReducerFilterSettings = struct {
    /// Relative strength of noise reducing filter. Higher values produce stronger
    /// filtering.
    strength: ?i32 = null,

    pub const json_field_names = .{
        .strength = "Strength",
    };
};
