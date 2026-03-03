const TrialComponentPrimaryStatus = @import("trial_component_primary_status.zig").TrialComponentPrimaryStatus;

/// The status of the trial component.
pub const TrialComponentStatus = struct {
    /// If the component failed, a message describing why.
    message: ?[]const u8 = null,

    /// The status of the trial component.
    primary_status: ?TrialComponentPrimaryStatus = null,

    pub const json_field_names = .{
        .message = "Message",
        .primary_status = "PrimaryStatus",
    };
};
