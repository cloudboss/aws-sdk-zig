const aws = @import("aws");

const AfterContactWorkConfigPerChannel = @import("after_contact_work_config_per_channel.zig").AfterContactWorkConfigPerChannel;
const AutoAcceptConfig = @import("auto_accept_config.zig").AutoAcceptConfig;
const UserIdentityInfoLite = @import("user_identity_info_lite.zig").UserIdentityInfoLite;
const PersistentConnectionConfig = @import("persistent_connection_config.zig").PersistentConnectionConfig;
const UserPhoneConfig = @import("user_phone_config.zig").UserPhoneConfig;
const PhoneNumberConfig = @import("phone_number_config.zig").PhoneNumberConfig;
const VoiceEnhancementConfig = @import("voice_enhancement_config.zig").VoiceEnhancementConfig;

/// Information about the returned users.
pub const UserSearchSummary = struct {
    /// The list of after contact work (ACW) timeout configuration settings for each
    /// channel.
    after_contact_work_configs: ?[]const AfterContactWorkConfigPerChannel = null,

    /// The Amazon Resource Name (ARN) of the user.
    arn: ?[]const u8 = null,

    /// The list of auto-accept configuration settings for each channel.
    auto_accept_configs: ?[]const AutoAcceptConfig = null,

    /// The directory identifier of the user.
    directory_user_id: ?[]const u8 = null,

    /// The identifier of the user's hierarchy group.
    hierarchy_group_id: ?[]const u8 = null,

    /// The identifier of the user's summary.
    id: ?[]const u8 = null,

    /// The user's first name and last name.
    identity_info: ?UserIdentityInfoLite = null,

    /// The list of persistent connection configuration settings for each channel.
    persistent_connection_configs: ?[]const PersistentConnectionConfig = null,

    phone_config: ?UserPhoneConfig = null,

    /// The list of phone number configuration settings for each channel.
    phone_number_configs: ?[]const PhoneNumberConfig = null,

    /// The identifier of the user's routing profile.
    routing_profile_id: ?[]const u8 = null,

    /// The identifiers of the user's security profiles.
    security_profile_ids: ?[]const []const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name of the user.
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
