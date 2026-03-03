const PerformanceTargetStatus = @import("performance_target_status.zig").PerformanceTargetStatus;

/// An object that represents the price performance target settings for the
/// workgroup.
pub const PerformanceTarget = struct {
    /// The target price performance level for the workgroup. Valid values include
    /// 1, 25, 50, 75, and 100. These correspond to the price performance levels
    /// LOW_COST, ECONOMICAL, BALANCED, RESOURCEFUL, and HIGH_PERFORMANCE.
    level: ?i32 = null,

    /// Whether the price performance target is enabled for the workgroup.
    status: ?PerformanceTargetStatus = null,

    pub const json_field_names = .{
        .level = "level",
        .status = "status",
    };
};
