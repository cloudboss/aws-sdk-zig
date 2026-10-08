const Status = @import("status.zig").Status;

/// Contains information about a brand profile.
pub const BrandProfileInfo = struct {
    /// The Amazon Resource Name (ARN) of the brand profile.
    brand_profile_arn: []const u8,

    /// The unique identifier of the brand profile.
    brand_profile_id: []const u8,

    /// The name of the brand profile. The name can contain alphanumeric characters,
    /// underscores, hyphens, and spaces.
    brand_profile_name: []const u8,

    /// The time when the resource was created, in Unix epoch time.
    created_at: i64,

    /// Specifies whether deletion protection is enabled. When enabled, the resource
    /// cannot be deleted until deletion protection is turned off.
    deletion_protection_enabled: bool,

    /// The current lifecycle status of the brand profile.
    status: Status,

    /// The time when the resource was last updated, in Unix epoch time.
    updated_at: i64,

    pub const json_field_names = .{
        .brand_profile_arn = "brandProfileArn",
        .brand_profile_id = "brandProfileId",
        .brand_profile_name = "brandProfileName",
        .created_at = "createdAt",
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
