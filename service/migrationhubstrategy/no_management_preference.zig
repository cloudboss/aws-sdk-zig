const NoPreferenceTargetDestination = @import("no_preference_target_destination.zig").NoPreferenceTargetDestination;

/// Object containing the choice of application destination that you specify.
pub const NoManagementPreference = struct {
    /// The choice of application destination that you specify.
    target_destination: []const NoPreferenceTargetDestination,

    pub const json_field_names = .{
        .target_destination = "targetDestination",
    };
};
