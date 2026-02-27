const LifecycleManagement = @import("lifecycle_management.zig").LifecycleManagement;

/// Settings related to idle shutdown of Studio applications.
pub const IdleSettings = struct {
    /// The time that SageMaker waits after the application becomes idle before
    /// shutting it down.
    idle_timeout_in_minutes: ?i32,

    /// Indicates whether idle shutdown is activated for the application type.
    lifecycle_management: ?LifecycleManagement,

    /// The maximum value in minutes that custom idle shutdown can be set to by the
    /// user.
    max_idle_timeout_in_minutes: ?i32,

    /// The minimum value in minutes that custom idle shutdown can be set to by the
    /// user.
    min_idle_timeout_in_minutes: ?i32,

    pub const json_field_names = .{
        .idle_timeout_in_minutes = "IdleTimeoutInMinutes",
        .lifecycle_management = "LifecycleManagement",
        .max_idle_timeout_in_minutes = "MaxIdleTimeoutInMinutes",
        .min_idle_timeout_in_minutes = "MinIdleTimeoutInMinutes",
    };
};
