const GlobalAcceleratorForDirectory = @import("global_accelerator_for_directory.zig").GlobalAcceleratorForDirectory;
const StorageConnector = @import("storage_connector.zig").StorageConnector;
const StreamingExperiencePreferredProtocolEnum = @import("streaming_experience_preferred_protocol_enum.zig").StreamingExperiencePreferredProtocolEnum;
const UserSetting = @import("user_setting.zig").UserSetting;

/// Describes the streaming properties.
pub const StreamingProperties = struct {
    /// Indicates the Global Accelerator properties.
    global_accelerator: ?GlobalAcceleratorForDirectory = null,

    /// Indicates the storage connector used
    storage_connectors: ?[]const StorageConnector = null,

    /// Indicates the type of preferred protocol for the streaming experience.
    streaming_experience_preferred_protocol: ?StreamingExperiencePreferredProtocolEnum = null,

    /// Indicates the permission settings asscoiated with the user.
    user_settings: ?[]const UserSetting = null,

    pub const json_field_names = .{
        .global_accelerator = "GlobalAccelerator",
        .storage_connectors = "StorageConnectors",
        .streaming_experience_preferred_protocol = "StreamingExperiencePreferredProtocol",
        .user_settings = "UserSettings",
    };
};
