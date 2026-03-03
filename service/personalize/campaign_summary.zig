/// Provides a summary of the properties of a campaign. For a complete listing,
/// call the
/// [DescribeCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeCampaign.html) API.
pub const CampaignSummary = struct {
    /// The Amazon Resource Name (ARN) of the campaign.
    campaign_arn: ?[]const u8 = null,

    /// The date and time (in Unix time) that the campaign was created.
    creation_date_time: ?i64 = null,

    /// If a campaign fails, the reason behind the failure.
    failure_reason: ?[]const u8 = null,

    /// The date and time (in Unix time) that the campaign was last updated.
    last_updated_date_time: ?i64 = null,

    /// The name of the campaign.
    name: ?[]const u8 = null,

    /// The status of the campaign.
    ///
    /// A campaign can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .campaign_arn = "campaignArn",
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .status = "status",
    };
};
