/// A summary of the Kinesis video stream pool.
pub const KinesisVideoStreamPoolSummary = struct {
    /// The ARN of the video stream pool.
    pool_arn: ?[]const u8 = null,

    /// The ID of the video stream pool.
    pool_id: ?[]const u8 = null,

    /// The name of the video stream pool.
    pool_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .pool_arn = "PoolArn",
        .pool_id = "PoolId",
        .pool_name = "PoolName",
    };
};
