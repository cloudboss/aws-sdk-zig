const ApplicationType = @import("application_type.zig").ApplicationType;

/// This API is in preview release for Amazon Connect and is subject to change.
///
/// A third-party application's metadata.
pub const Application = struct {
    /// The permissions that the agent is granted on the application. For
    /// third-party applications, only the
    /// `ACCESS` permission is supported. For MCP Servers, the permissions are tool
    /// Identifiers accepted by MCP
    /// Server.
    application_permissions: ?[]const []const u8 = null,

    /// Namespace of the application that you want to give access to.
    namespace: ?[]const u8 = null,

    /// Type of Application.
    @"type": ?ApplicationType = null,

    pub const json_field_names = .{
        .application_permissions = "ApplicationPermissions",
        .namespace = "Namespace",
        .@"type" = "Type",
    };
};
