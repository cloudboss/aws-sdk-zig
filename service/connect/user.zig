const aws = @import("aws");

const UserIdentityInfo = @import("user_identity_info.zig").UserIdentityInfo;
const UserPhoneConfig = @import("user_phone_config.zig").UserPhoneConfig;

/// Contains information about a user account for an Amazon Connect instance.
pub const User = struct {
    /// The Amazon Resource Name (ARN) of the user account.
    arn: ?[]const u8 = null,

    /// The identifier of the user account in the directory used for identity
    /// management.
    directory_user_id: ?[]const u8 = null,

    /// The identifier of the hierarchy group for the user.
    hierarchy_group_id: ?[]const u8 = null,

    /// The identifier of the user account.
    id: ?[]const u8 = null,

    /// Information about the user identity.
    identity_info: ?UserIdentityInfo = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// Information about the phone configuration for the user.
    phone_config: ?UserPhoneConfig = null,

    /// The identifier of the routing profile for the user.
    routing_profile_id: ?[]const u8 = null,

    /// The identifiers of the security profiles for the user.
    security_profile_ids: ?[]const []const u8 = null,

    /// The
    /// tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The user name assigned to the user account.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .directory_user_id = "DirectoryUserId",
        .hierarchy_group_id = "HierarchyGroupId",
        .id = "Id",
        .identity_info = "IdentityInfo",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .phone_config = "PhoneConfig",
        .routing_profile_id = "RoutingProfileId",
        .security_profile_ids = "SecurityProfileIds",
        .tags = "Tags",
        .username = "Username",
    };
};
