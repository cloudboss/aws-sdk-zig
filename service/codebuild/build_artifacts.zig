const BucketOwnerAccess = @import("bucket_owner_access.zig").BucketOwnerAccess;

/// Information about build output artifacts.
pub const BuildArtifacts = struct {
    /// An identifier for this artifact definition.
    artifact_identifier: ?[]const u8 = null,

    bucket_owner_access: ?BucketOwnerAccess = null,

    /// Information that tells you if encryption for build artifacts is disabled.
    encryption_disabled: ?bool = null,

    /// Information about the location of the build artifacts.
    location: ?[]const u8 = null,

    /// The MD5 hash of the build artifact.
    ///
    /// You can use this hash along with a checksum tool to confirm file integrity
    /// and
    /// authenticity.
    ///
    /// This value is available only if the build project's `packaging` value
    /// is set to `ZIP`.
    md_5_sum: ?[]const u8 = null,

    /// If this flag is set, a name specified in the buildspec file overrides the
    /// artifact
    /// name. The name specified in a buildspec file is calculated at build time and
    /// uses the
    /// Shell Command Language. For example, you can append a date and time to your
    /// artifact
    /// name so that it is always unique.
    override_artifact_name: ?bool = null,

    /// The SHA-256 hash of the build artifact.
    ///
    /// You can use this hash along with a checksum tool to confirm file integrity
    /// and
    /// authenticity.
    ///
    /// This value is available only if the build project's `packaging` value
    /// is set to `ZIP`.
    sha_256_sum: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_identifier = "artifactIdentifier",
        .bucket_owner_access = "bucketOwnerAccess",
        .encryption_disabled = "encryptionDisabled",
        .location = "location",
        .md_5_sum = "md5sum",
        .override_artifact_name = "overrideArtifactName",
        .sha_256_sum = "sha256sum",
    };
};
