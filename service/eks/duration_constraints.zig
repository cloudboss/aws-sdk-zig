/// Constraints for a duration parameter.
pub const DurationConstraints = struct {
    /// The maximum allowed duration value.
    max: ?[]const u8 = null,

    /// The minimum allowed duration value.
    min: ?[]const u8 = null,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
