const Tags = @import("tags.zig").Tags;

/// The connection group for your distribution tenants. When you first create a
/// distribution tenant and you don't specify a connection group, CloudFront
/// will automatically create a default connection group for you. When you
/// create a new distribution tenant and don't specify a connection group, the
/// default one will be associated with your distribution tenant.
pub const ConnectionGroup = struct {
    /// The ID of the Anycast static IP list.
    anycast_ip_list_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the connection group.
    arn: ?[]const u8 = null,

    /// The date and time when the connection group was created.
    created_time: ?i64 = null,

    /// Whether the connection group is enabled.
    enabled: ?bool = null,

    /// The ID of the connection group.
    id: ?[]const u8 = null,

    /// IPv6 is enabled for the connection group.
    ipv_6_enabled: ?bool = null,

    /// Whether the connection group is the default connection group for the
    /// distribution tenants.
    is_default: ?bool = null,

    /// The date and time when the connection group was updated.
    last_modified_time: ?i64 = null,

    /// The name of the connection group.
    name: ?[]const u8 = null,

    /// The routing endpoint (also known as the DNS name) that is assigned to the
    /// connection group, such as d111111abcdef8.cloudfront.net.
    routing_endpoint: ?[]const u8 = null,

    /// The status of the connection group.
    status: ?[]const u8 = null,

    tags: ?Tags = null,
};
