const FlagValue = @import("flag_value.zig").FlagValue;

/// Input structure for defining a treatment when creating or updating an
/// experiment definition.
pub const TreatmentInput = struct {
    /// A description of the treatment.
    description: ?[]const u8 = null,

    /// The feature flag value to serve to users assigned to this treatment.
    flag_value: FlagValue,

    /// The traffic allocation weight for this treatment.
    weight: f32 = 0,

    pub const json_field_names = .{
        .description = "Description",
        .flag_value = "FlagValue",
        .weight = "Weight",
    };
};
