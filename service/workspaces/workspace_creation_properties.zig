/// Describes the default properties that are used for creating WorkSpaces. For
/// more
/// information, see [Update Directory
/// Details for Your
/// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/update-directory-details.html).
pub const WorkspaceCreationProperties = struct {
    /// The identifier of your custom security group.
    custom_security_group_id: ?[]const u8 = null,

    /// The default organizational unit (OU) for your WorkSpaces directories. This
    /// string must
    /// be the full Lightweight Directory Access Protocol (LDAP) distinguished name
    /// for the target
    /// domain and OU. It must be in the form
    /// `"OU=*value*,DC=*value*,DC=*value*"`,
    /// where *value* is any string of characters, and the number of domain
    /// components (DCs) is two or more. For example,
    /// `OU=WorkSpaces_machines,DC=machines,DC=example,DC=com`.
    ///
    /// * To avoid errors, certain characters in the distinguished name must be
    ///   escaped.
    /// For more information, see [ Distinguished
    /// Names](https://docs.microsoft.com/previous-versions/windows/desktop/ldap/distinguished-names) in the Microsoft documentation.
    ///
    /// * The API doesn't validate whether the OU exists.
    default_ou: ?[]const u8 = null,

    /// Indicates whether internet access is enabled for your WorkSpaces.
    enable_internet_access: ?bool = null,

    /// Indicates whether maintenance mode is enabled for your WorkSpaces. For more
    /// information,
    /// see [WorkSpace
    /// Maintenance](https://docs.aws.amazon.com/workspaces/latest/adminguide/workspace-maintenance.html).
    enable_maintenance_mode: ?bool = null,

    /// Indicates the IAM role ARN of the instance.
    instance_iam_role_arn: ?[]const u8 = null,

    /// Indicates whether users are local administrators of their WorkSpaces.
    user_enabled_as_local_administrator: ?bool = null,

    pub const json_field_names = .{
        .custom_security_group_id = "CustomSecurityGroupId",
        .default_ou = "DefaultOu",
        .enable_internet_access = "EnableInternetAccess",
        .enable_maintenance_mode = "EnableMaintenanceMode",
        .instance_iam_role_arn = "InstanceIamRoleArn",
        .user_enabled_as_local_administrator = "UserEnabledAsLocalAdministrator",
    };
};
