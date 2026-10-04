/// The configuration identifies the CloudWatch dataset used as a scraper
/// destination.
pub const CloudWatchConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch dataset. To use the default
    /// dataset, specify `arn:aws:cloudwatch:<region>:<account-id>:dataset/default`.
    dataset_arn: []const u8,

    pub const json_field_names = .{
        .dataset_arn = "datasetArn",
    };
};
