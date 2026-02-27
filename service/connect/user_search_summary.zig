const aws = @import("aws");

const UserIdentityInfoLite = @import("user_identity_info_lite.zig").UserIdentityInfoLite;
const UserPhoneConfig = @import("user_phone_config.zig").UserPhoneConfig;

/// Information about the returned users.
pub const UserSearchSummary = struct {
    /// The Amazon Resource Name (ARN) of the user.
    arn: ?[]const u8,

    /// The directory identifier of the user.
    directory_user_id: ?[]const u8,

    /// The identifier of the user's hierarchy group.
    hierarchy_group_id: ?[]const u8,

    /// The identifier of the user's summary.
    id: ?[]const u8,

    /// The user's first name and last name.
    identity_info: ?UserIdentityInfoLite,

    phone_config: ?UserPhoneConfig,

    /// The identifier of the user's routing profile.
    routing_profile_id: ?[]const u8,

    /// The identifiers of the user's security profiles.
    security_profile_ids: ?[]const []const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

    /// The name of the user.
    username: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .directory_user_id = "DirectoryUserId",
        .hierarchy_group_id = "HierarchyGroupId",
        .id = "Id",
        .identity_info = "IdentityInfo",
        .phone_config = "PhoneConfig",
        .routing_profile_id = "RoutingProfileId",
        .security_profile_ids = "SecurityProfileIds",
        .tags = "Tags",
        .username = "Username",
    };
};
