const S3Object = @import("s3_object.zig").S3Object;

/// Summary that provides statistics on input manifest and errors identified in
/// the input manifest.
pub const MediaAnalysisManifestSummary = struct {
    s3_object: ?S3Object = null,

    pub const json_field_names = .{
        .s3_object = "S3Object",
    };
};
