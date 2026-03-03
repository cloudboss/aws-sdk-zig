/// Describes the default values that are used to create WorkSpaces. For more
/// information,
/// see [Update Directory
/// Details for Your
/// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/update-directory-details.html).
pub const DefaultWorkspaceCreationProperties = struct {
    /// The identifier of the default security group to apply to WorkSpaces when
    /// they are
    /// created. For more information, see [ Security
    /// Groups for Your
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/amazon-workspaces-security-groups.html).
    custom_security_group_id: ?[]const u8 = null,

    /// The organizational unit (OU) in the directory for the WorkSpace machine
    /// accounts.
    default_ou: ?[]const u8 = null,

    /// Specifies whether to automatically assign an Elastic public IP address to
    /// WorkSpaces in
    /// this directory by default. If enabled, the Elastic public IP address allows
    /// outbound
    /// internet access from your WorkSpaces when you’re using an internet gateway
    /// in the Amazon
    /// VPC in which your WorkSpaces are located. If you're using a Network Address
    /// Translation
    /// (NAT) gateway for outbound internet access from your VPC, or if your
    /// WorkSpaces are in
    /// public subnets and you manually assign them Elastic IP addresses, you should
    /// disable this
    /// setting. This setting applies to new WorkSpaces that you launch or to
    /// existing WorkSpaces
    /// that you rebuild. For more information, see [ Configure a VPC for
    /// Amazon
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/amazon-workspaces-vpc.html).
    enable_internet_access: ?bool = null,

    /// Specifies whether maintenance mode is enabled for WorkSpaces. For more
    /// information, see
    /// [WorkSpace
    /// Maintenance](https://docs.aws.amazon.com/workspaces/latest/adminguide/workspace-maintenance.html).
    enable_maintenance_mode: ?bool = null,

    /// Indicates the IAM role ARN of the instance.
    instance_iam_role_arn: ?[]const u8 = null,

    /// Specifies whether WorkSpace users are local administrators on their
    /// WorkSpaces.
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
