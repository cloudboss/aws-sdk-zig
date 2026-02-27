const OutPutS3Location = @import("out_put_s3_location.zig").OutPutS3Location;

/// Results of a package import job.
pub const PackageImportJobOutput = struct {
    /// The package's output location.
    output_s3_location: OutPutS3Location,

    /// The package's ID.
    package_id: []const u8,

    /// The package's version.
    package_version: []const u8,

    /// The package's patch version.
    patch_version: []const u8,

    pub const json_field_names = .{
        .output_s3_location = "OutputS3Location",
        .package_id = "PackageId",
        .package_version = "PackageVersion",
        .patch_version = "PatchVersion",
    };
};
