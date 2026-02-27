const CampaignConfig = @import("campaign_config.zig").CampaignConfig;

/// Provides a summary of the properties of a campaign update. For a complete
/// listing, call the
/// [DescribeCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeCampaign.html) API.
pub const CampaignUpdateSummary = struct {
    campaign_config: ?CampaignConfig,

    /// The date and time (in Unix time) that the campaign update was created.
    creation_date_time: ?i64,

    /// If a campaign update fails, the reason behind the failure.
    failure_reason: ?[]const u8,

    /// The date and time (in Unix time) that the campaign update was last updated.
    last_updated_date_time: ?i64,

    /// Specifies the requested minimum provisioned transactions (recommendations)
    /// per second that
    /// Amazon Personalize will support.
    min_provisioned_tps: ?i32,

    /// The Amazon Resource Name (ARN) of the deployed solution version.
    solution_version_arn: ?[]const u8,

    /// The status of the campaign update.
    ///
    /// A campaign update can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8,

    pub const json_field_names = .{
        .campaign_config = "campaignConfig",
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .min_provisioned_tps = "minProvisionedTPS",
        .solution_version_arn = "solutionVersionArn",
        .status = "status",
    };
};
