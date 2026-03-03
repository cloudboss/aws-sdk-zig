const ChannelSubtype = @import("channel_subtype.zig").ChannelSubtype;
const Schedule = @import("schedule.zig").Schedule;
const ExternalCampaignType = @import("external_campaign_type.zig").ExternalCampaignType;

/// An Amazon Connect campaign summary.
pub const CampaignSummary = struct {
    arn: []const u8,

    channel_subtypes: []const ChannelSubtype,

    connect_campaign_flow_arn: ?[]const u8 = null,

    connect_instance_id: []const u8,

    id: []const u8,

    name: []const u8,

    schedule: ?Schedule = null,

    @"type": ?ExternalCampaignType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .channel_subtypes = "channelSubtypes",
        .connect_campaign_flow_arn = "connectCampaignFlowArn",
        .connect_instance_id = "connectInstanceId",
        .id = "id",
        .name = "name",
        .schedule = "schedule",
        .@"type" = "type",
    };
};
