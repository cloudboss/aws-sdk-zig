const SigningRepositoryFilter = @import("signing_repository_filter.zig").SigningRepositoryFilter;

/// A signing rule that specifies a signing profile and optional
/// repository filters. When an image is pushed to a matching repository, a
/// signing job is created using the specified profile.
pub const SigningRule = struct {
    /// A list of repository filters that determine which repositories
    /// have their images signed on push. If no filters are specified, all
    /// images pushed to the registry are signed using the rule's signing
    /// profile. Maximum of 100 filters per rule.
    repository_filters: ?[]const SigningRepositoryFilter,

    /// The ARN of the Amazon Web Services Signer signing profile to use for signing
    /// images that match this
    /// rule. For more information about signing profiles, see [Signing
    /// profiles](https://docs.aws.amazon.com/signer/latest/developerguide/signing-profiles.html) in
    /// the *Amazon Web Services Signer Developer Guide*.
    signing_profile_arn: []const u8,

    pub const json_field_names = .{
        .repository_filters = "repositoryFilters",
        .signing_profile_arn = "signingProfileArn",
    };
};
