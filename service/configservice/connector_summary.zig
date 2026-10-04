const Provider = @import("provider.zig").Provider;

/// A summary of a connector.
pub const ConnectorSummary = struct {
    /// The Amazon Resource Name (ARN) of the connector.
    arn: []const u8,

    /// The date and time that the connector was created.
    created_time: i64,

    /// The name of the connector.
    name: []const u8,

    /// The third-party cloud service provider. Currently, `AZURE` is supported.
    provider: Provider,

    /// The Azure tenant identifier for the connector.
    tenant_identifier: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .name = "name",
        .provider = "provider",
        .tenant_identifier = "tenantIdentifier",
    };
};
