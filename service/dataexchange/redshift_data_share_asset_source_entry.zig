/// The source of the Amazon Redshift datashare asset.
pub const RedshiftDataShareAssetSourceEntry = struct {
    /// The Amazon Resource Name (ARN) of the datashare asset.
    data_share_arn: []const u8,

    pub const json_field_names = .{
        .data_share_arn = "DataShareArn",
    };
};
