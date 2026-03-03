const InsightStatusValue = @import("insight_status_value.zig").InsightStatusValue;

/// The status of the insight.
pub const InsightStatus = struct {
    /// Explanation on the reasoning for the status of the resource.
    reason: ?[]const u8 = null,

    /// The status of the resource.
    status: ?InsightStatusValue = null,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
