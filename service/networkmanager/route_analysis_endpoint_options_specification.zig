/// Describes a source or a destination.
pub const RouteAnalysisEndpointOptionsSpecification = struct {
    /// The IP address.
    ip_address: ?[]const u8,

    /// The ARN of the transit gateway attachment.
    transit_gateway_attachment_arn: ?[]const u8,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .transit_gateway_attachment_arn = "TransitGatewayAttachmentArn",
    };
};
