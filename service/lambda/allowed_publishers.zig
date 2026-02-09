/// List of signing profiles that can sign a code package.
pub const AllowedPublishers = struct {
    /// The Amazon Resource Name (ARN) for each of the signing profiles. A signing
    /// profile defines a trusted user who can sign a code package.
    signing_profile_version_arns: []const []const u8,
};
