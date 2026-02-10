const IpamExternalResourceVerificationTokenState = @import("ipam_external_resource_verification_token_state.zig").IpamExternalResourceVerificationTokenState;
const TokenState = @import("token_state.zig").TokenState;
const Tag = @import("tag.zig").Tag;

/// A verification token is an Amazon Web Services-generated random value that
/// you can use to prove ownership of an external resource. For example, you can
/// use a verification token to validate that you control a public IP address
/// range when you bring an IP address range to Amazon Web Services (BYOIP).
pub const IpamExternalResourceVerificationToken = struct {
    /// ARN of the IPAM that created the token.
    ipam_arn: ?[]const u8,

    /// Token ARN.
    ipam_external_resource_verification_token_arn: ?[]const u8,

    /// The ID of the token.
    ipam_external_resource_verification_token_id: ?[]const u8,

    /// The ID of the IPAM that created the token.
    ipam_id: ?[]const u8,

    /// Region of the IPAM that created the token.
    ipam_region: ?[]const u8,

    /// Token expiration.
    not_after: ?i64,

    /// Token state.
    state: ?IpamExternalResourceVerificationTokenState,

    /// Token status.
    status: ?TokenState,

    /// Token tags.
    tags: ?[]const Tag,

    /// Token name.
    token_name: ?[]const u8,

    /// Token value.
    token_value: ?[]const u8,
};
