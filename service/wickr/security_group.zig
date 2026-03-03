const SecurityGroupSettings = @import("security_group_settings.zig").SecurityGroupSettings;

/// Represents a security group in a Wickr network, containing membership
/// statistics, configuration, and all permission settings that apply to its
/// members.
pub const SecurityGroup = struct {
    /// The GUID of the Active Directory group associated with this security group,
    /// if synchronized with LDAP.
    active_directory_guid: ?[]const u8 = null,

    /// The number of active user members currently in the security group.
    active_members: i32,

    /// The number of bot members currently in the security group.
    bot_members: i32,

    /// The unique identifier of the security group.
    id: []const u8,

    /// Indicates whether this is the default security group for the network. Each
    /// network has only one default group.
    is_default: bool,

    /// The timestamp when the security group was last modified, specified in epoch
    /// seconds.
    modified: i32,

    /// The human-readable name of the security group.
    name: []const u8,

    /// The comprehensive configuration settings that define capabilities and
    /// restrictions for members of this security group.
    security_group_settings: SecurityGroupSettings,

    pub const json_field_names = .{
        .active_directory_guid = "activeDirectoryGuid",
        .active_members = "activeMembers",
        .bot_members = "botMembers",
        .id = "id",
        .is_default = "isDefault",
        .modified = "modified",
        .name = "name",
        .security_group_settings = "securityGroupSettings",
    };
};
