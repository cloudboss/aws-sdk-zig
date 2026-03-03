const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;
const ProviderType = @import("provider_type.zig").ProviderType;

/// A resource that is used to connect third-party source providers with
/// services like CodePipeline.
///
/// Note: A connection created through CloudFormation, the CLI, or the SDK is in
/// `PENDING` status by default. You can make its status `AVAILABLE` by updating
/// the
/// connection in the console.
pub const Connection = struct {
    /// The Amazon Resource Name (ARN) of the connection. The ARN is used as the
    /// connection
    /// reference when the connection is shared between Amazon Web Services
    /// services.
    ///
    /// The ARN is never reused if the connection is deleted.
    connection_arn: ?[]const u8 = null,

    /// The name of the connection. Connection names must be unique in an Amazon Web
    /// Services account.
    connection_name: ?[]const u8 = null,

    /// The current status of the connection.
    connection_status: ?ConnectionStatus = null,

    /// The Amazon Resource Name (ARN) of the host associated with the connection.
    host_arn: ?[]const u8 = null,

    /// The identifier of the external provider where your third-party code
    /// repository is configured.
    /// For Bitbucket, this is the account ID of the owner of the Bitbucket
    /// repository.
    owner_account_id: ?[]const u8 = null,

    /// The name of the external provider where your third-party code repository is
    /// configured.
    provider_type: ?ProviderType = null,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .connection_name = "ConnectionName",
        .connection_status = "ConnectionStatus",
        .host_arn = "HostArn",
        .owner_account_id = "OwnerAccountId",
        .provider_type = "ProviderType",
    };
};
