const EcrRescanDurationState = @import("ecr_rescan_duration_state.zig").EcrRescanDurationState;

/// Details about the state of the ECR scans for your environment.
pub const EcrConfigurationState = struct {
    /// An object that contains details about the state of the ECR re-scan settings.
    rescan_duration_state: ?EcrRescanDurationState,

    pub const json_field_names = .{
        .rescan_duration_state = "rescanDurationState",
    };
};
