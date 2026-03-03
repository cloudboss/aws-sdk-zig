const S3Detail = @import("s3_detail.zig").S3Detail;

/// Complex data type that defines destination-detail objects.
pub const DestinationDetail = struct {
    /// An S3 detail object to return information about the S3 destination.
    s_3: ?S3Detail = null,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
