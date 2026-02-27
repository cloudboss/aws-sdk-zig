const BlockPublicAccess = @import("block_public_access.zig").BlockPublicAccess;

/// Contains information about the account level permissions on the S3 bucket.
pub const AccountLevelPermissions = struct {
    /// Describes the S3 Block Public Access settings of the bucket's parent
    /// account.
    block_public_access: ?BlockPublicAccess,

    pub const json_field_names = .{
        .block_public_access = "BlockPublicAccess",
    };
};
