const OverrideButtonConfiguration = @import("override_button_configuration.zig").OverrideButtonConfiguration;
const DefaultButtonConfiguration = @import("default_button_configuration.zig").DefaultButtonConfiguration;

/// Button Config for an in-app message.
pub const InAppMessageButton = struct {
    /// Default button content.
    android: ?OverrideButtonConfiguration,

    /// Default button content.
    default_config: ?DefaultButtonConfiguration,

    /// Default button content.
    ios: ?OverrideButtonConfiguration,

    /// Default button content.
    web: ?OverrideButtonConfiguration,

    pub const json_field_names = .{
        .android = "Android",
        .default_config = "DefaultConfig",
        .ios = "IOS",
        .web = "Web",
    };
};
