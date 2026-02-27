const S3ModelDataSource = @import("s3_model_data_source.zig").S3ModelDataSource;

/// Data sources that are available to your model in addition to the one that
/// you specify for `ModelDataSource` when you use the `CreateModel` action.
pub const AdditionalModelDataSource = struct {
    /// A custom name for this `AdditionalModelDataSource` object.
    channel_name: []const u8,

    s3_data_source: S3ModelDataSource,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .s3_data_source = "S3DataSource",
    };
};
