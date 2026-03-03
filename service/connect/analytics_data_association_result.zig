/// This API is in preview release for Amazon Connect and is subject to change.
///
/// Information about associations that are successfully created: `DataSetId`,
/// `TargetAccountId`, `ResourceShareId`,
/// `ResourceShareArn`.
pub const AnalyticsDataAssociationResult = struct {
    /// The identifier of the dataset.
    data_set_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Resource Access Manager share.
    resource_share_arn: ?[]const u8 = null,

    /// The Resource Access Manager share ID.
    resource_share_id: ?[]const u8 = null,

    /// The Amazon Web Services Resource Access Manager status of association.
    resource_share_status: ?[]const u8 = null,

    /// The identifier of the target account.
    target_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
        .resource_share_arn = "ResourceShareArn",
        .resource_share_id = "ResourceShareId",
        .resource_share_status = "ResourceShareStatus",
        .target_account_id = "TargetAccountId",
    };
};
