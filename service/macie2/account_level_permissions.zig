const BlockPublicAccess = @import("block_public_access.zig").BlockPublicAccess;

/// Provides information about the account-level permissions settings that apply
/// to an S3 bucket.
pub const AccountLevelPermissions = struct {
    /// The block public access settings for the Amazon Web Services account that
    /// owns the bucket.
    block_public_access: ?BlockPublicAccess = null,

    pub const json_field_names = .{
        .block_public_access = "blockPublicAccess",
    };
};
