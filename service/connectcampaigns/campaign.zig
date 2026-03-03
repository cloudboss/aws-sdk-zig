const aws = @import("aws");

const DialerConfig = @import("dialer_config.zig").DialerConfig;
const OutboundCallConfig = @import("outbound_call_config.zig").OutboundCallConfig;

/// An Amazon Connect campaign.
pub const Campaign = struct {
    arn: []const u8,

    connect_instance_id: []const u8,

    dialer_config: DialerConfig,

    id: []const u8,

    name: []const u8,

    outbound_call_config: OutboundCallConfig,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .connect_instance_id = "connectInstanceId",
        .dialer_config = "dialerConfig",
        .id = "id",
        .name = "name",
        .outbound_call_config = "outboundCallConfig",
        .tags = "tags",
    };
};
