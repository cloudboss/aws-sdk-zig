const CampaignStatus = @import("campaign_status.zig").CampaignStatus;

/// Information about a campaign.
///
/// You can use the API operation to return this
/// information about multiple created campaigns.
pub const CampaignSummary = struct {
    /// The Amazon Resource Name (ARN) of a campaign.
    arn: ?[]const u8,

    /// The time the campaign was created.
    creation_time: i64,

    /// The description of the campaign.
    description: ?[]const u8,

    /// The last time the campaign was modified.
    last_modification_time: i64,

    /// The name of a campaign.
    name: ?[]const u8,

    /// The ARN of the signal catalog associated with the campaign.
    signal_catalog_arn: ?[]const u8,

    /// The state of a campaign. The status can be one of the following:
    ///
    /// * `CREATING` - Amazon Web Services IoT FleetWise is processing your request
    ///   to create the
    /// campaign.
    ///
    /// * `WAITING_FOR_APPROVAL` - After a campaign is created, it enters the
    /// `WAITING_FOR_APPROVAL` state. To allow Amazon Web Services IoT FleetWise to
    /// deploy the
    /// campaign to the target vehicle or fleet, use the API operation to approve
    /// the campaign.
    ///
    /// * `RUNNING` - The campaign is active.
    ///
    /// * `SUSPENDED` - The campaign is suspended. To resume the campaign, use
    /// the API operation.
    status: ?CampaignStatus,

    /// The ARN of a vehicle or fleet to which the campaign is deployed.
    target_arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .last_modification_time = "lastModificationTime",
        .name = "name",
        .signal_catalog_arn = "signalCatalogArn",
        .status = "status",
        .target_arn = "targetArn",
    };
};
