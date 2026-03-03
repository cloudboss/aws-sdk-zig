/// An entity that contains IAM policies.
pub const PermissionSet = struct {
    /// The date that the permission set was created.
    created_date: ?i64 = null,

    /// The description of the PermissionSet.
    description: ?[]const u8 = null,

    /// The name of the permission set.
    name: ?[]const u8 = null,

    /// The ARN of the permission set. For more information about ARNs, see [Amazon
    /// Resource Names (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    permission_set_arn: ?[]const u8 = null,

    /// Used to redirect users within the application during the federation
    /// authentication process.
    relay_state: ?[]const u8 = null,

    /// The length of time that the application user sessions are valid for in the
    /// ISO-8601 standard.
    session_duration: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .description = "Description",
        .name = "Name",
        .permission_set_arn = "PermissionSetArn",
        .relay_state = "RelayState",
        .session_duration = "SessionDuration",
    };
};
