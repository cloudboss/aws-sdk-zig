/// The Amazon Redshift datashare asset.
pub const RedshiftDataShareAsset = struct {
    /// The Amazon Resource Name (ARN) of the datashare asset.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
