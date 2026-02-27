const PrincipalType = @import("principal_type.zig").PrincipalType;

/// A structure that describes an assignment of a principal to an application.
pub const ApplicationAssignment = struct {
    /// The ARN of the application that has principals assigned.
    application_arn: []const u8,

    /// The unique identifier of the principal assigned to the application.
    principal_id: []const u8,

    /// The type of the principal assigned to the application.
    principal_type: PrincipalType,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .principal_id = "PrincipalId",
        .principal_type = "PrincipalType",
    };
};
