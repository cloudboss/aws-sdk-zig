const OriginProtocolPolicyEnum = @import("origin_protocol_policy_enum.zig").OriginProtocolPolicyEnum;
const RegionName = @import("region_name.zig").RegionName;

/// Describes the origin resource of an Amazon Lightsail content delivery
/// network (CDN)
/// distribution.
///
/// An origin can be a Lightsail instance, bucket, container service, or load
/// balancer. A
/// distribution pulls content from an origin, caches it, and serves it to
/// viewers via a worldwide
/// network of edge servers.
pub const InputOrigin = struct {
    /// The name of the origin resource.
    name: ?[]const u8 = null,

    /// The protocol that your Amazon Lightsail distribution uses when establishing
    /// a connection
    /// with your origin to pull content.
    protocol_policy: ?OriginProtocolPolicyEnum = null,

    /// The AWS Region name of the origin resource.
    region_name: ?RegionName = null,

    /// The amount of time, in seconds, that the distribution waits for a response
    /// after
    /// forwarding a request to the origin. The minimum timeout is 1 second, the
    /// maximum is 60
    /// seconds, and the default (if you don't specify otherwise) is 30 seconds.
    response_timeout: ?i32 = null,

    pub const json_field_names = .{
        .name = "name",
        .protocol_policy = "protocolPolicy",
        .region_name = "regionName",
        .response_timeout = "responseTimeout",
    };
};
