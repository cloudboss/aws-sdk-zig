const S3Object = @import("s3_object.zig").S3Object;

/// Contains input information for a media analysis job.
pub const MediaAnalysisInput = struct {
    s3_object: S3Object,

    pub const json_field_names = .{
        .s3_object = "S3Object",
    };
};
