const EnvironmentAccountConnectionStatus = @import("environment_account_connection_status.zig").EnvironmentAccountConnectionStatus;

/// Summary data of an Proton environment account connection resource.
pub const EnvironmentAccountConnectionSummary = struct {
    /// The Amazon Resource Name (ARN) of the environment account connection.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM service role that Proton uses when
    /// provisioning directly defined components in the associated
    /// environment account. It determines the scope of infrastructure that a
    /// component can provision in the account.
    ///
    /// The environment account connection must have a `componentRoleArn` to allow
    /// directly defined components to be associated with any
    /// environments running in the account.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    component_role_arn: ?[]const u8,

    /// The ID of the environment account that's connected to the environment
    /// account connection.
    environment_account_id: []const u8,

    /// The name of the environment that's associated with the environment account
    /// connection.
    environment_name: []const u8,

    /// The ID of the environment account connection.
    id: []const u8,

    /// The time when the environment account connection was last modified.
    last_modified_at: i64,

    /// The ID of the management account that's connected to the environment account
    /// connection.
    management_account_id: []const u8,

    /// The time when the environment account connection request was made.
    requested_at: i64,

    /// The IAM service role that's associated with the environment account
    /// connection.
    role_arn: []const u8,

    /// The status of the environment account connection.
    status: EnvironmentAccountConnectionStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .component_role_arn = "componentRoleArn",
        .environment_account_id = "environmentAccountId",
        .environment_name = "environmentName",
        .id = "id",
        .last_modified_at = "lastModifiedAt",
        .management_account_id = "managementAccountId",
        .requested_at = "requestedAt",
        .role_arn = "roleArn",
        .status = "status",
    };
};
