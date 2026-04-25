const aws = @import("aws");

const AfterContactWorkConfigPerChannel = @import("after_contact_work_config_per_channel.zig").AfterContactWorkConfigPerChannel;
const AutoAcceptConfig = @import("auto_accept_config.zig").AutoAcceptConfig;
const UserIdentityInfo = @import("user_identity_info.zig").UserIdentityInfo;
const PersistentConnectionConfig = @import("persistent_connection_config.zig").PersistentConnectionConfig;
const UserPhoneConfig = @import("user_phone_config.zig").UserPhoneConfig;
const PhoneNumberConfig = @import("phone_number_config.zig").PhoneNumberConfig;
const VoiceEnhancementConfig = @import("voice_enhancement_config.zig").VoiceEnhancementConfig;

/// Contains information about a user account for an Amazon Connect instance.
pub const User = struct {
    /// The list of after contact work (ACW) timeout configuration settings for each
    /// channel.
    after_contact_work_configs: ?[]const AfterContactWorkConfigPerChannel = null,

    /// The Amazon Resource Name (ARN) of the user account.
    arn: ?[]const u8 = null,

    /// The list of auto-accept configuration settings for each channel.
    auto_accept_configs: ?[]const AutoAcceptConfig = null,

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

    /// The list of persistent connection configuration settings for each channel.
    persistent_connection_configs: ?[]const PersistentConnectionConfig = null,

    /// Information about the phone configuration for the user.
    phone_config: ?UserPhoneConfig = null,

    /// The list of phone number configuration settings for each channel.
    phone_number_configs: ?[]const PhoneNumberConfig = null,

    /// The identifier of the routing profile for the user.
    routing_profile_id: ?[]const u8 = null,

    /// The identifiers of the security profiles for the user.
    security_profile_ids: ?[]const []const u8 = null,

    /// The
    /// tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The user name assigned to the user account.
    username: ?[]const u8 = null,

    /// The list of voice enhancement configuration settings for each channel.
    voice_enhancement_configs: ?[]const VoiceEnhancementConfig = null,

    pub const json_field_names = .{
        .after_contact_work_configs = "AfterContactWorkConfigs",
        .arn = "Arn",
        .auto_accept_configs = "AutoAcceptConfigs",
        .directory_user_id = "DirectoryUserId",
        .hierarchy_group_id = "HierarchyGroupId",
        .id = "Id",
        .identity_info = "IdentityInfo",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .persistent_connection_configs = "PersistentConnectionConfigs",
        .phone_config = "PhoneConfig",
        .phone_number_configs = "PhoneNumberConfigs",
        .routing_profile_id = "RoutingProfileId",
        .security_profile_ids = "SecurityProfileIds",
        .tags = "Tags",
        .username = "Username",
        .voice_enhancement_configs = "VoiceEnhancementConfigs",
    };
};
