/// The channel-specific configurations for the journey.
pub const JourneyChannelSettings = struct {
    /// Amazon Resource Name (ARN) of the Connect Campaign.
    connect_campaign_arn: ?[]const u8,

    /// IAM role ARN to be assumed when invoking Connect campaign execution APIs for
    /// dialing.
    connect_campaign_execution_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .connect_campaign_arn = "ConnectCampaignArn",
        .connect_campaign_execution_role_arn = "ConnectCampaignExecutionRoleArn",
    };
};
