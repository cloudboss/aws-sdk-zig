const S3Location = @import("s3_location.zig").S3Location;

/// A specific package version artifact associated with a software package
/// version.
pub const PackageVersionArtifact = struct {
    s_3_location: ?S3Location = null,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
    };
};
