const aws = @import("aws");

const EventConfig = @import("event_config.zig").EventConfig;

/// Describes an AppSync API. You can use `Api` for an AppSync API with your
/// preferred configuration, such as an Event API that provides
/// real-time message publishing and message subscriptions over WebSockets.
pub const Api = struct {
    /// The Amazon Resource Name (ARN) for the `Api`.
    api_arn: ?[]const u8 = null,

    /// The `Api` ID.
    api_id: ?[]const u8 = null,

    /// The date and time that the `Api` was created.
    created: ?i64 = null,

    /// The DNS records for the API. This will include an HTTP and a real-time
    /// endpoint.
    dns: ?[]const aws.map.StringMapEntry = null,

    /// The Event API configuration. This includes the default authorization
    /// configuration for
    /// connecting, publishing, and subscribing to an Event API.
    event_config: ?EventConfig = null,

    /// The name of the `Api`.
    name: ?[]const u8 = null,

    /// The owner contact information for the `Api`
    owner_contact: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the WAF web access control list (web
    /// ACL) associated with this `Api`, if one exists.
    waf_web_acl_arn: ?[]const u8 = null,

    /// A flag indicating whether to use X-Ray tracing for this
    /// `Api`.
    xray_enabled: bool = false,

    pub const json_field_names = .{
        .api_arn = "apiArn",
        .api_id = "apiId",
        .created = "created",
        .dns = "dns",
        .event_config = "eventConfig",
        .name = "name",
        .owner_contact = "ownerContact",
        .tags = "tags",
        .waf_web_acl_arn = "wafWebAclArn",
        .xray_enabled = "xrayEnabled",
    };
};
