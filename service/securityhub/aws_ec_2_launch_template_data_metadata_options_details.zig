/// Specifies the metadata options for an Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataMetadataOptionsDetails = struct {
    /// Enables or disables the HTTP metadata endpoint on your instances. If the
    /// parameter is
    /// not specified, the default state is enabled, and you won't be able to access
    /// your instance
    /// metadata.
    http_endpoint: ?[]const u8 = null,

    /// Enables or disables the IPv6 endpoint for the instance metadata service.
    http_protocol_ipv_6: ?[]const u8 = null,

    /// The desired HTTP PUT response hop limit for instance metadata requests. The
    /// larger
    /// the number, the further instance metadata requests can travel.
    http_put_response_hop_limit: ?i32 = null,

    /// The state of token usage for your instance metadata requests.
    http_tokens: ?[]const u8 = null,

    /// When set to `enabled`, this parameter allows access to instance tags from
    /// the instance metadata. When set to `disabled`, it turns off access to
    /// instance tags from the instance metadata. For more information, see
    /// [Work with instance tags in instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#work-with-tags-in-IMDS) in the *Amazon EC2 User Guide*.
    instance_metadata_tags: ?[]const u8 = null,

    pub const json_field_names = .{
        .http_endpoint = "HttpEndpoint",
        .http_protocol_ipv_6 = "HttpProtocolIpv6",
        .http_put_response_hop_limit = "HttpPutResponseHopLimit",
        .http_tokens = "HttpTokens",
        .instance_metadata_tags = "InstanceMetadataTags",
    };
};
