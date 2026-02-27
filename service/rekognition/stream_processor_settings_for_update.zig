const ConnectedHomeSettingsForUpdate = @import("connected_home_settings_for_update.zig").ConnectedHomeSettingsForUpdate;

/// The stream processor settings that you want to update. `ConnectedHome`
/// settings can be updated to detect different labels with a different minimum
/// confidence.
pub const StreamProcessorSettingsForUpdate = struct {
    /// The label detection settings you want to use for your stream processor.
    connected_home_for_update: ?ConnectedHomeSettingsForUpdate,

    pub const json_field_names = .{
        .connected_home_for_update = "ConnectedHomeForUpdate",
    };
};
