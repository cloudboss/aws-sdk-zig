const AccountConstraint = @import("account_constraint.zig").AccountConstraint;
const WorkloadStatus = @import("workload_status.zig").WorkloadStatus;

/// Describes workload data.
pub const WorkloadDataSummary = struct {
    /// Optional list of constraints describing what kind of AWS account is allowed
    /// to deploy this workload or deployment pattern. Within a single list the
    /// semantics are OR: an account satisfies the list if it satisfies any entry.
    /// Workload-level and pattern-level lists combine with AND at deployment time.
    /// An absent or empty list at this level means no constraint at this level.
    account_constraints: ?[]const AccountConstraint = null,

    /// The display name of the workload data.
    display_name: ?[]const u8 = null,

    /// The status of the workload.
    status: ?WorkloadStatus = null,

    /// The name of the workload.
    workload_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_constraints = "accountConstraints",
        .display_name = "displayName",
        .status = "status",
        .workload_name = "workloadName",
    };
};
