const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

/// Summary of an application for list operations
pub const ApplicationSummary = struct {
    /// ARN of the application
    arn: []const u8,

    /// Timestamp when the application was created
    created_at: i64,

    /// Unique identifier of the application
    id: []const u8,

    /// Name of the application
    name: []const u8,

    /// Current status of the application
    status: ApplicationStatus,

    /// Name of the workspace this application belongs to
    workspace_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .name = "name",
        .status = "status",
        .workspace_name = "workspaceName",
    };
};
