const S3Location = @import("s3_location.zig").S3Location;

/// Describes the location where the restore job's output is stored.
pub const OutputLocation = struct {
    /// Describes an S3 location that will receive the results of the restore
    /// request.
    s3: ?S3Location,
};
