const PrincipalType = @import("principal_type.zig").PrincipalType;

/// A structure that describes an application to which a principal is assigned.
pub const ApplicationAssignmentForPrincipal = struct {
    /// The ARN of the application to which the specified principal is assigned.
    application_arn: ?[]const u8 = null,

    /// The unique identifier of the principal assigned to the application.
    principal_id: ?[]const u8 = null,

    /// The type of the principal assigned to the application.
    principal_type: ?PrincipalType = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .principal_id = "PrincipalId",
        .principal_type = "PrincipalType",
    };
};
