const S3Source = @import("s3_source.zig").S3Source;

/// An `S3Source` object that contains information about the S3 bucket where
/// you saved your unsigned code.
pub const Source = struct {
    /// The `S3Source` object.
    s_3: ?S3Source = null,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
