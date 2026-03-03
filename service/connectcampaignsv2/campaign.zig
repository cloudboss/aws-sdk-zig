const aws = @import("aws");

const ChannelSubtypeConfig = @import("channel_subtype_config.zig").ChannelSubtypeConfig;
const CommunicationLimitsConfig = @import("communication_limits_config.zig").CommunicationLimitsConfig;
const CommunicationTimeConfig = @import("communication_time_config.zig").CommunicationTimeConfig;
const Schedule = @import("schedule.zig").Schedule;
const Source = @import("source.zig").Source;
const ExternalCampaignType = @import("external_campaign_type.zig").ExternalCampaignType;

/// An Amazon Connect campaign.
pub const Campaign = struct {
    arn: []const u8,

    channel_subtype_config: ?ChannelSubtypeConfig = null,

    communication_limits_override: ?CommunicationLimitsConfig = null,

    communication_time_config: ?CommunicationTimeConfig = null,

    connect_campaign_flow_arn: ?[]const u8 = null,

    connect_instance_id: []const u8,

    id: []const u8,

    name: []const u8,

    schedule: ?Schedule = null,

    source: ?Source = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    @"type": ?ExternalCampaignType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .channel_subtype_config = "channelSubtypeConfig",
        .communication_limits_override = "communicationLimitsOverride",
        .communication_time_config = "communicationTimeConfig",
        .connect_campaign_flow_arn = "connectCampaignFlowArn",
        .connect_instance_id = "connectInstanceId",
        .id = "id",
        .name = "name",
        .schedule = "schedule",
        .source = "source",
        .tags = "tags",
        .@"type" = "type",
    };
};
