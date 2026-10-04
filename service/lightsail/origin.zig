const OriginIpAddressTypeEnum = @import("origin_ip_address_type_enum.zig").OriginIpAddressTypeEnum;
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
    /// The IP address type that the distribution uses when connecting to the
    /// origin.
    ///
    /// The possible values are `ipv4` for IPv4 only, `ipv6` for IPv6 only,
    /// and `dualstack` for IPv4 and IPv6.
    ip_address_type: ?OriginIpAddressTypeEnum = null,

    /// Specifies whether private origin access is enabled for the distribution's
    /// origin. With
    /// private origin access, the distribution can serve objects that aren't
    /// publicly accessible
    /// from a Lightsail bucket.
    ///
    /// This applies when you set the bucket's `getObject` access rule to
    /// `private`. It also applies when you set `getObject` to `public`
    /// but set individual objects to private.
    is_private_origin_access_enabled: ?bool = null,

    /// The name of the origin resource.
    name: ?[]const u8 = null,

    /// The protocol that your Amazon Lightsail distribution uses when establishing
    /// a connection
    /// with your origin to pull content.
    protocol_policy: ?OriginProtocolPolicyEnum = null,

    /// The AWS Region name of the origin resource.
    region_name: ?RegionName = null,

    /// The resource type of the origin resource (*Instance*).
    resource_type: ?ResourceType = null,

    /// The amount of time, in seconds, that the distribution waits for a response
    /// after
    /// forwarding a request to the origin. The minimum timeout is 1 second, the
    /// maximum is 60
    /// seconds, and the default (if you don't specify otherwise) is 30 seconds.
    response_timeout: ?i32 = null,

    pub const json_field_names = .{
        .ip_address_type = "ipAddressType",
        .is_private_origin_access_enabled = "isPrivateOriginAccessEnabled",
        .name = "name",
        .protocol_policy = "protocolPolicy",
        .region_name = "regionName",
        .resource_type = "resourceType",
        .response_timeout = "responseTimeout",
    };
};
