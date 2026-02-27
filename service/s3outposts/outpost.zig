/// Contains the details for the Outpost object.
pub const Outpost = struct {
    /// The Amazon S3 capacity of the outpost in bytes.
    capacity_in_bytes: i64 = 0,

    /// Specifies the unique Amazon Resource Name (ARN) for the outpost.
    outpost_arn: ?[]const u8,

    /// Specifies the unique identifier for the outpost.
    outpost_id: ?[]const u8,

    /// Returns the Amazon Web Services account ID of the outpost owner. Useful for
    /// comparing owned versus shared outposts.
    owner_id: ?[]const u8,

    /// Specifies the unique S3 on Outposts ARN for use with Resource Access Manager
    /// (RAM).
    s3_outpost_arn: ?[]const u8,

    pub const json_field_names = .{
        .capacity_in_bytes = "CapacityInBytes",
        .outpost_arn = "OutpostArn",
        .outpost_id = "OutpostId",
        .owner_id = "OwnerId",
        .s3_outpost_arn = "S3OutpostArn",
    };
};
