const WorkspaceConfigurationStatusCode = @import("workspace_configuration_status_code.zig").WorkspaceConfigurationStatusCode;

/// This structure displays the current status of the workspace configuration,
/// and might also contain a reason for that status.
pub const WorkspaceConfigurationStatus = struct {
    /// The current status of the workspace configuration.
    status_code: WorkspaceConfigurationStatusCode,

    /// The reason for the current status, if a reason is available.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};
