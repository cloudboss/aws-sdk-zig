const FlagValue = @import("flag_value.zig").FlagValue;

/// Describes a treatment in an experiment, including its traffic allocation
/// weight and feature flag value.
pub const Treatment = struct {
    /// A description of the treatment.
    description: ?[]const u8 = null,

    /// The feature flag value served to users assigned to this treatment.
    flag_value: FlagValue,

    /// The unique key that identifies this treatment.
    key: ?[]const u8 = null,

    /// The traffic allocation weight for this treatment.
    weight: f32 = 0,

    pub const json_field_names = .{
        .description = "Description",
        .flag_value = "FlagValue",
        .key = "Key",
        .weight = "Weight",
    };
};
