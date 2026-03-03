/// A summary that contains details about your connection groups.
pub const ConnectionGroupSummary = struct {
    /// The ID of the Anycast static IP list.
    anycast_ip_list_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the connection group.
    arn: []const u8,

    /// The date and time when the connection group was created.
    created_time: i64,

    /// Whether the connection group is enabled
    enabled: ?bool = null,

    /// The current version of the connection group.
    e_tag: []const u8,

    /// The ID of the connection group.
    id: []const u8,

    /// Whether the connection group is the default connection group for the
    /// distribution tenants.
    is_default: ?bool = null,

    /// The date and time when the connection group was updated.
    last_modified_time: i64,

    /// The name of the connection group.
    name: []const u8,

    /// The routing endpoint (also known as the DNS name) that is assigned to the
    /// connection group, such as d111111abcdef8.cloudfront.net.
    routing_endpoint: []const u8,

    /// The status of the connection group.
    status: ?[]const u8 = null,
};
