/// A set of wildcard version ARNs that always reference the latest
/// version of the resource. ARNs are included for the latest version overall,
/// and for the latest
/// versions within the same major, minor, and patch levels.
pub const LatestVersionReferences = struct {
    /// The latest version Amazon Resource Name (ARN) with the same `major` version
    /// of the Image Builder resource.
    latest_major_version_arn: ?[]const u8 = null,

    /// The latest version Amazon Resource Name (ARN) with the same `minor` version
    /// of the Image Builder resource.
    latest_minor_version_arn: ?[]const u8 = null,

    /// The latest version Amazon Resource Name (ARN) with the same `patch` version
    /// of the Image Builder resource.
    latest_patch_version_arn: ?[]const u8 = null,

    /// The latest version Amazon Resource Name (ARN) of the Image Builder resource.
    latest_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .latest_major_version_arn = "latestMajorVersionArn",
        .latest_minor_version_arn = "latestMinorVersionArn",
        .latest_patch_version_arn = "latestPatchVersionArn",
        .latest_version_arn = "latestVersionArn",
    };
};
