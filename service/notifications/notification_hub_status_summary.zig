const NotificationHubStatus = @import("notification_hub_status.zig").NotificationHubStatus;

/// Provides additional information about the current `NotificationHub` status.
pub const NotificationHubStatusSummary = struct {
    /// An explanation for the current status.
    reason: []const u8,

    /// Status information about the `NotificationHub`.
    ///
    /// * Values:
    ///
    /// * `ACTIVE`
    ///
    /// * Incoming `NotificationEvents` are replicated to this `NotificationHub`.
    ///
    /// * `REGISTERING`
    ///
    /// * The `NotificationConfiguration` is initializing. A
    ///   `NotificationConfiguration` with this status can't be deregistered.
    ///
    /// * `DEREGISTERING`
    ///
    /// * The `NotificationConfiguration` is being deleted. You can't register
    ///   additional `NotificationHubs` in the same Region as a
    ///   `NotificationConfiguration` with this status.
    status: NotificationHubStatus,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
