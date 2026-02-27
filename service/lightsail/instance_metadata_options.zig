const HttpEndpoint = @import("http_endpoint.zig").HttpEndpoint;
const HttpProtocolIpv6 = @import("http_protocol_ipv_6.zig").HttpProtocolIpv6;
const HttpTokens = @import("http_tokens.zig").HttpTokens;
const InstanceMetadataState = @import("instance_metadata_state.zig").InstanceMetadataState;

/// The metadata options for the instance.
pub const InstanceMetadataOptions = struct {
    /// Indicates whether the HTTP metadata endpoint on your instances is enabled or
    /// disabled.
    ///
    /// If the value is `disabled`, you cannot access your instance metadata.
    http_endpoint: ?HttpEndpoint,

    /// Indicates whether the IPv6 endpoint for the instance metadata service is
    /// enabled or
    /// disabled.
    http_protocol_ipv_6: ?HttpProtocolIpv6,

    /// The desired HTTP PUT response hop limit for instance metadata requests. A
    /// larger number
    /// means that the instance metadata requests can travel farther.
    http_put_response_hop_limit: ?i32,

    /// The state of token usage for your instance metadata requests.
    ///
    /// If the state is `optional`, you can choose whether to retrieve instance
    /// metadata with a signed token header on your request. If you retrieve the IAM
    /// role credentials
    /// without a token, the version 1.0 role credentials are returned. If you
    /// retrieve the IAM role
    /// credentials by using a valid signed token, the version 2.0 role credentials
    /// are
    /// returned.
    ///
    /// If the state is `required`, you must send a signed token header with all
    /// instance metadata retrieval requests. In this state, retrieving the IAM role
    /// credential always
    /// returns the version 2.0 credentials. The version 1.0 credentials are not
    /// available.
    ///
    /// Not all instance blueprints in Lightsail support version 2.0 credentials.
    /// Use the `MetadataNoToken` instance metric to track the number of calls to
    /// the
    /// instance metadata service that are using version 1.0 credentials. For more
    /// information, see
    /// [Viewing instance metrics in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-viewing-instance-health-metrics) in the *Amazon Lightsail Developer Guide*.
    http_tokens: ?HttpTokens,

    /// The state of the metadata option changes.
    ///
    /// The following states are possible:
    ///
    /// * `pending` - The metadata options are being updated. The instance is not
    ///   yet
    /// ready to process metadata traffic with the new selection.
    ///
    /// * `applied` - The metadata options have been successfully applied to the
    /// instance.
    state: ?InstanceMetadataState,

    pub const json_field_names = .{
        .http_endpoint = "httpEndpoint",
        .http_protocol_ipv_6 = "httpProtocolIpv6",
        .http_put_response_hop_limit = "httpPutResponseHopLimit",
        .http_tokens = "httpTokens",
        .state = "state",
    };
};
