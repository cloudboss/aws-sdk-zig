const Readiness = @import("readiness.zig").Readiness;

/// Summary of all readiness check statuses in a recovery group, paginated in
/// GetRecoveryGroupReadinessSummary and GetCellReadinessSummary.
pub const ReadinessCheckSummary = struct {
    /// The readiness status of this readiness check.
    readiness: ?Readiness,

    /// The name of a readiness check.
    readiness_check_name: ?[]const u8,

    pub const json_field_names = .{
        .readiness = "Readiness",
        .readiness_check_name = "ReadinessCheckName",
    };
};
