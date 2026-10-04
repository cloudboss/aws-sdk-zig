const aws = @import("aws");

const ProfileLimitValue = @import("profile_limit_value.zig").ProfileLimitValue;

/// A limits profile that defines resource usage limits for Amazon Quick Sight
/// users. Limits profiles can be assigned to users, groups, or roles to control
/// resource consumption.
pub const LimitsProfile = struct {
    /// The ID of the Amazon Web Services account that contains the limits profile.
    account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the limits profile.
    arn: []const u8,

    /// The date and time that the limits profile was created.
    created_at: i64,

    /// The description of the limits profile.
    description: ?[]const u8 = null,

    /// The unique identifier for the limits profile.
    profile_id: []const u8,

    /// The display name of the limits profile.
    profile_name: []const u8,

    /// A map of resource types to their limit values.
    resource_limits: []const aws.map.MapEntry(ProfileLimitValue),

    /// The date and time that the limits profile was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .account_id = "accountId",
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .profile_id = "profileId",
        .profile_name = "profileName",
        .resource_limits = "resourceLimits",
        .updated_at = "updatedAt",
    };
};
