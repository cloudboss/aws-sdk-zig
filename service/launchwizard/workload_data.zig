const WorkloadStatus = @import("workload_status.zig").WorkloadStatus;

/// Describes a workload.
pub const WorkloadData = struct {
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
        .description = "description",
        .display_name = "displayName",
        .documentation_url = "documentationUrl",
        .icon_url = "iconUrl",
        .status = "status",
        .status_message = "statusMessage",
        .workload_name = "workloadName",
    };
};
