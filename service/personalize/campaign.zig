const CampaignConfig = @import("campaign_config.zig").CampaignConfig;
const CampaignUpdateSummary = @import("campaign_update_summary.zig").CampaignUpdateSummary;

/// An object that describes the deployment of a solution version.
/// For more information on campaigns, see
/// [CreateCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateCampaign.html).
pub const Campaign = struct {
    /// The Amazon Resource Name (ARN) of the campaign.
    campaign_arn: ?[]const u8,

    /// The configuration details of a campaign.
    campaign_config: ?CampaignConfig,

    /// The date and time (in Unix format) that the campaign was created.
    creation_date_time: ?i64,

    /// If a campaign fails, the reason behind the failure.
    failure_reason: ?[]const u8,

    /// The date and time (in Unix format) that the campaign was last updated.
    last_updated_date_time: ?i64,

    /// Provides a summary of the properties of a campaign update. For a complete
    /// listing, call the
    /// [DescribeCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeCampaign.html) API.
    ///
    /// The `latestCampaignUpdate` field is only returned when the campaign has had
    /// at least one `UpdateCampaign` call.
    latest_campaign_update: ?CampaignUpdateSummary,

    /// Specifies the requested minimum provisioned transactions (recommendations)
    /// per second. A high `minProvisionedTPS` will increase your bill. We recommend
    /// starting with 1 for `minProvisionedTPS` (the default). Track
    /// your usage using Amazon CloudWatch metrics, and increase the
    /// `minProvisionedTPS`
    /// as necessary.
    min_provisioned_tps: ?i32,

    /// The name of the campaign.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the solution version the campaign uses.
    solution_version_arn: ?[]const u8,

    /// The status of the campaign.
    ///
    /// A campaign can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8,

    pub const json_field_names = .{
        .campaign_arn = "campaignArn",
        .campaign_config = "campaignConfig",
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .latest_campaign_update = "latestCampaignUpdate",
        .min_provisioned_tps = "minProvisionedTPS",
        .name = "name",
        .solution_version_arn = "solutionVersionArn",
        .status = "status",
    };
};
