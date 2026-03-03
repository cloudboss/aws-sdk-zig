/// Metadata options that allow you to configure and secure the Amazon EC2
/// instance.
pub const AwsEc2InstanceMetadataOptions = struct {
    /// Enables or disables the HTTP metadata endpoint on the instance.
    http_endpoint: ?[]const u8 = null,

    /// Enables or disables the IPv6 endpoint for the instance metadata service.
    http_protocol_ipv_6: ?[]const u8 = null,

    /// The desired HTTP PUT response hop limit for instance metadata requests.
    /// The larger the number, the further instance metadata requests can travel.
    http_put_response_hop_limit: ?i32 = null,

    /// The state of token usage for your instance metadata requests.
    http_tokens: ?[]const u8 = null,

    /// Specifies whether to allow access to instance tags from the instance
    /// metadata.
    instance_metadata_tags: ?[]const u8 = null,

    pub const json_field_names = .{
        .http_endpoint = "HttpEndpoint",
        .http_protocol_ipv_6 = "HttpProtocolIpv6",
        .http_put_response_hop_limit = "HttpPutResponseHopLimit",
        .http_tokens = "HttpTokens",
        .instance_metadata_tags = "InstanceMetadataTags",
    };
};
