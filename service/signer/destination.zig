const S3Destination = @import("s3_destination.zig").S3Destination;

/// Points to an `S3Destination` object that contains information about your S3
/// bucket.
pub const Destination = struct {
    /// The `S3Destination` object.
    s_3: ?S3Destination = null,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
