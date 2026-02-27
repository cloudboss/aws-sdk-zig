/// The metadata options for the instances.
pub const AwsAutoScalingLaunchConfigurationMetadataOptions = struct {
    /// Enables or disables the HTTP metadata endpoint on your instances. By
    /// default, the metadata endpoint is enabled.
    http_endpoint: ?[]const u8,

    /// The HTTP `PUT` response hop limit for instance metadata requests. The larger
    /// the number, the further instance metadata requests can travel.
    http_put_response_hop_limit: ?i32,

    /// Indicates whether token usage is `required` or `optional` for metadata
    /// requests. By default, token usage is `optional`.
    http_tokens: ?[]const u8,

    pub const json_field_names = .{
        .http_endpoint = "HttpEndpoint",
        .http_put_response_hop_limit = "HttpPutResponseHopLimit",
        .http_tokens = "HttpTokens",
    };
};
