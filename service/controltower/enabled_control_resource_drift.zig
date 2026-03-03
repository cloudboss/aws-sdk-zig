const DriftStatus = @import("drift_status.zig").DriftStatus;

/// Represents drift information related to the underlying Amazon Web Services
/// resources managed by the control.
pub const EnabledControlResourceDrift = struct {
    /// The status of resource drift for the enabled control, indicating whether the
    /// underlying resources match the expected configuration.
    status: ?DriftStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
