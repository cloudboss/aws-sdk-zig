const OriginProtocolPolicyEnum = @import("origin_protocol_policy_enum.zig").OriginProtocolPolicyEnum;
const RegionName = @import("region_name.zig").RegionName;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Describes the origin resource of an Amazon Lightsail content delivery
/// network (CDN)
/// distribution.
///
/// An origin can be a Lightsail instance, bucket, or load balancer. A
/// distribution pulls
/// content from an origin, caches it, and serves it to viewers via a worldwide
/// network of edge
/// servers.
pub const Origin = struct {
    /// The name of the origin resource.
    name: ?[]const u8,

    /// The protocol that your Amazon Lightsail distribution uses when establishing
    /// a connection
    /// with your origin to pull content.
    protocol_policy: ?OriginProtocolPolicyEnum,

    /// The AWS Region name of the origin resource.
    region_name: ?RegionName,

    /// The resource type of the origin resource (*Instance*).
    resource_type: ?ResourceType,

    /// The amount of time, in seconds, that the distribution waits for a response
    /// after
    /// forwarding a request to the origin. The minimum timeout is 1 second, the
    /// maximum is 60
    /// seconds, and the default (if you don't specify otherwise) is 30 seconds.
    response_timeout: ?i32,

    pub const json_field_names = .{
        .name = "name",
        .protocol_policy = "protocolPolicy",
        .region_name = "regionName",
        .resource_type = "resourceType",
        .response_timeout = "responseTimeout",
    };
};
