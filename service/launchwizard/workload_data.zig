const AccountConstraint = @import("account_constraint.zig").AccountConstraint;
const WorkloadStatus = @import("workload_status.zig").WorkloadStatus;

/// Describes a workload.
pub const WorkloadData = struct {
    /// Optional list of constraints describing what kind of AWS account is allowed
    /// to deploy this workload or deployment pattern. Within a single list the
    /// semantics are OR: an account satisfies the list if it satisfies any entry.
    /// Workload-level and pattern-level lists combine with AND at deployment time.
    /// An absent or empty list at this level means no constraint at this level.
    account_constraints: ?[]const AccountConstraint = null,

    /// The description of a workload.
    description: ?[]const u8 = null,

    /// The display name of a workload.
    display_name: ?[]const u8 = null,

    /// The URL of a workload document.
    documentation_url: ?[]const u8 = null,

    /// The URL of a workload icon.
    icon_url: ?[]const u8 = null,

    /// The status of a workload.
    ///
    /// *You can list deployments in the `DISABLED` status.*
    status: ?WorkloadStatus = null,

    /// The message about a workload's status.
    status_message: ?[]const u8 = null,

    /// The name of the workload.
    workload_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_constraints = "accountConstraints",
        .description = "description",
        .display_name = "displayName",
        .documentation_url = "documentationUrl",
        .icon_url = "iconUrl",
        .status = "status",
        .status_message = "statusMessage",
        .workload_name = "workloadName",
    };
};
