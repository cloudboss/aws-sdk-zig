const EndpointConfig = @import("endpoint_config.zig").EndpointConfig;
const Status = @import("status.zig").Status;

/// Contains details about an endpoint for a model from Amazon Bedrock
/// Marketplace.
pub const MarketplaceModelEndpoint = struct {
    /// The timestamp when the endpoint was registered.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    /// The configuration of the endpoint, including the number and type of
    /// instances used.
    endpoint_config: EndpointConfig,

    /// The current status of the endpoint (e.g., Creating, InService, Updating,
    /// Failed).
    endpoint_status: []const u8,

    /// Additional information about the endpoint status, if available.
    endpoint_status_message: ?[]const u8,

    /// The ARN of the model from Amazon Bedrock Marketplace that is deployed on
    /// this endpoint.
    model_source_identifier: []const u8,

    /// The overall status of the endpoint in Amazon Bedrock Marketplace (e.g.,
    /// ACTIVE, INACTIVE).
    status: ?Status,

    /// Additional information about the overall status, if available.
    status_message: ?[]const u8,

    /// The timestamp when the endpoint was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .endpoint_arn = "endpointArn",
        .endpoint_config = "endpointConfig",
        .endpoint_status = "endpointStatus",
        .endpoint_status_message = "endpointStatusMessage",
        .model_source_identifier = "modelSourceIdentifier",
        .status = "status",
        .status_message = "statusMessage",
        .updated_at = "updatedAt",
    };
};
