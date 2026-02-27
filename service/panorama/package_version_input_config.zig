const S3Location = @import("s3_location.zig").S3Location;

/// A package version input configuration.
pub const PackageVersionInputConfig = struct {
    /// A location in Amazon S3.
    s3_location: S3Location,

    pub const json_field_names = .{
        .s3_location = "S3Location",
    };
};
