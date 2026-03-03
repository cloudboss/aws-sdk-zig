const S3Object = @import("s3_object.zig").S3Object;

/// The dataset configuration options for a given version of an adapter.
/// Can include an Amazon S3 bucket if specified.
pub const AdapterVersionDatasetConfig = struct {
    manifest_s3_object: ?S3Object = null,

    pub const json_field_names = .{
        .manifest_s3_object = "ManifestS3Object",
    };
};
