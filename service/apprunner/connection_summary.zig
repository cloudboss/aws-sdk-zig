const ProviderType = @import("provider_type.zig").ProviderType;
const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

/// Provides summary information about an App Runner connection resource.
pub const ConnectionSummary = struct {
    /// The Amazon Resource Name (ARN) of this connection.
    connection_arn: ?[]const u8,

    /// The customer-provided connection name.
    connection_name: ?[]const u8,

    /// The App Runner connection creation time, expressed as a Unix time stamp.
    created_at: ?i64,

    /// The source repository provider.
    provider_type: ?ProviderType,

    /// The current state of the App Runner connection. When the state is
    /// `AVAILABLE`, you can use the connection to create an App Runner service.
    status: ?ConnectionStatus,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .connection_name = "ConnectionName",
        .created_at = "CreatedAt",
        .provider_type = "ProviderType",
        .status = "Status",
    };
};
