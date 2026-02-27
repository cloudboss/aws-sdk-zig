const HttpEndpointEnum = @import("http_endpoint_enum.zig").HttpEndpointEnum;
const HttpProtocolIpv6Enum = @import("http_protocol_ipv_6_enum.zig").HttpProtocolIpv6Enum;
const HttpTokensEnum = @import("http_tokens_enum.zig").HttpTokensEnum;
const InstanceMetadataTagsEnum = @import("instance_metadata_tags_enum.zig").InstanceMetadataTagsEnum;

/// Defines instance metadata service configuration.
pub const InstanceMetadataOptionsRequest = struct {
    /// Enables or disables HTTP endpoint for instance metadata.
    http_endpoint: ?HttpEndpointEnum,

    /// Configures IPv6 support for instance metadata HTTP protocol.
    http_protocol_ipv_6: ?HttpProtocolIpv6Enum,

    /// Sets maximum number of network hops for metadata PUT responses.
    http_put_response_hop_limit: ?i32,

    /// Configures token requirement for instance metadata retrieval.
    http_tokens: ?HttpTokensEnum,

    /// Enables or disables instance metadata tags retrieval.
    instance_metadata_tags: ?InstanceMetadataTagsEnum,

    pub const json_field_names = .{
        .http_endpoint = "HttpEndpoint",
        .http_protocol_ipv_6 = "HttpProtocolIpv6",
        .http_put_response_hop_limit = "HttpPutResponseHopLimit",
        .http_tokens = "HttpTokens",
        .instance_metadata_tags = "InstanceMetadataTags",
    };
};
