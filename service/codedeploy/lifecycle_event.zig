const Diagnostics = @import("diagnostics.zig").Diagnostics;
const LifecycleEventStatus = @import("lifecycle_event_status.zig").LifecycleEventStatus;

/// Information about a deployment lifecycle event.
pub const LifecycleEvent = struct {
    /// Diagnostic information about the deployment lifecycle event.
    diagnostics: ?Diagnostics = null,

    /// A timestamp that indicates when the deployment lifecycle event ended.
    end_time: ?i64 = null,

    /// The deployment lifecycle event name, such as `ApplicationStop`,
    /// `BeforeInstall`, `AfterInstall`,
    /// `ApplicationStart`, or `ValidateService`.
    lifecycle_event_name: ?[]const u8 = null,

    /// A timestamp that indicates when the deployment lifecycle event started.
    start_time: ?i64 = null,

    /// The deployment lifecycle event status:
    ///
    /// * Pending: The deployment lifecycle event is pending.
    ///
    /// * InProgress: The deployment lifecycle event is in progress.
    ///
    /// * Succeeded: The deployment lifecycle event ran successfully.
    ///
    /// * Failed: The deployment lifecycle event has failed.
    ///
    /// * Skipped: The deployment lifecycle event has been skipped.
    ///
    /// * Unknown: The deployment lifecycle event is unknown.
    status: ?LifecycleEventStatus = null,

    pub const json_field_names = .{
        .diagnostics = "diagnostics",
        .end_time = "endTime",
        .lifecycle_event_name = "lifecycleEventName",
        .start_time = "startTime",
        .status = "status",
    };
};
