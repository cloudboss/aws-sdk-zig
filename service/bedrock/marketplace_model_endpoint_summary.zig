const Status = @import("status.zig").Status;

/// Provides a summary of an endpoint for a model from Amazon Bedrock
/// Marketplace.
pub const MarketplaceModelEndpointSummary = struct {
    /// The timestamp when the endpoint was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    /// The ARN of the model from Amazon Bedrock Marketplace that is deployed on
    /// this endpoint.
    model_source_identifier: []const u8,

    /// The overall status of the endpoint in Amazon Bedrock Marketplace.
    status: ?Status = null,

    /// Additional information about the overall status, if available.
    status_message: ?[]const u8 = null,

    /// The timestamp when the endpoint was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .endpoint_arn = "endpointArn",
        .model_source_identifier = "modelSourceIdentifier",
        .status = "status",
        .status_message = "statusMessage",
        .updated_at = "updatedAt",
    };
};
