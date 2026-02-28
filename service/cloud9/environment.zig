const ConnectionType = @import("connection_type.zig").ConnectionType;
const EnvironmentLifecycle = @import("environment_lifecycle.zig").EnvironmentLifecycle;
const ManagedCredentialsStatus = @import("managed_credentials_status.zig").ManagedCredentialsStatus;
const EnvironmentType = @import("environment_type.zig").EnvironmentType;

/// Information about an Cloud9 development environment.
pub const Environment = struct {
    /// The Amazon Resource Name (ARN) of the environment.
    arn: []const u8,

    /// The connection type used for connecting to an Amazon EC2 environment.
    /// `CONNECT_SSH`
    /// is selected by default.
    connection_type: ?ConnectionType,

    /// The description for the environment.
    description: ?[]const u8,

    /// The ID of the environment.
    id: ?[]const u8,

    /// The state of the environment in its creation or deletion lifecycle.
    lifecycle: ?EnvironmentLifecycle,

    /// Describes the status of Amazon Web Services managed temporary credentials
    /// for the Cloud9 environment.
    /// Available values are:
    ///
    /// * `ENABLED_ON_CREATE`
    ///
    /// * `ENABLED_BY_OWNER`
    ///
    /// * `DISABLED_BY_DEFAULT`
    ///
    /// * `DISABLED_BY_OWNER`
    ///
    /// * `DISABLED_BY_COLLABORATOR`
    ///
    /// * `PENDING_REMOVAL_BY_COLLABORATOR`
    ///
    /// * `PENDING_REMOVAL_BY_OWNER`
    ///
    /// * `FAILED_REMOVAL_BY_COLLABORATOR`
    ///
    /// * `ENABLED_BY_OWNER`
    ///
    /// * `DISABLED_BY_DEFAULT`
    managed_credentials_status: ?ManagedCredentialsStatus,

    /// The name of the environment.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the environment owner.
    owner_arn: []const u8,

    /// The type of environment. Valid values include the following:
    ///
    /// * `ec2`: An Amazon Elastic Compute Cloud (Amazon EC2) instance connects to
    ///   the environment.
    ///
    /// * `ssh`: Your own server connects to the environment.
    @"type": EnvironmentType,

    pub const json_field_names = .{
        .arn = "arn",
        .connection_type = "connectionType",
        .description = "description",
        .id = "id",
        .lifecycle = "lifecycle",
        .managed_credentials_status = "managedCredentialsStatus",
        .name = "name",
        .owner_arn = "ownerArn",
        .@"type" = "type",
    };
};
