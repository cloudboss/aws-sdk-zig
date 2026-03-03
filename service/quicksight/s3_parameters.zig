const ManifestFileLocation = @import("manifest_file_location.zig").ManifestFileLocation;

/// The parameters for S3.
pub const S3Parameters = struct {
    /// Location of the Amazon S3 manifest file. This is NULL if the manifest file
    /// was
    /// uploaded into Quick Sight.
    manifest_file_location: ManifestFileLocation,

    /// Use the `RoleArn` structure to override an account-wide role for a specific
    /// S3 data source. For example, say an account administrator has turned off all
    /// S3 access with an account-wide role. The administrator can then use
    /// `RoleArn` to bypass the account-wide role and allow S3 access for the single
    /// S3 data source that is specified in the structure, even if the account-wide
    /// role forbidding S3 access is still active.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .manifest_file_location = "ManifestFileLocation",
        .role_arn = "RoleArn",
    };
};
