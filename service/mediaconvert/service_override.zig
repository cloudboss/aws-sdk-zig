/// A service override applied by MediaConvert to the settings that you have
/// configured. If you see any overrides, we recommend that you contact AWS
/// Support.
pub const ServiceOverride = struct {
    /// Details about the service override that MediaConvert has applied.
    message: ?[]const u8,

    /// The name of the setting that MediaConvert has applied an override to.
    name: ?[]const u8,

    /// The current value of the service override that MediaConvert has applied.
    override_value: ?[]const u8,

    /// The value of the setting that you configured, prior to any overrides that
    /// MediaConvert has applied.
    value: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
        .override_value = "OverrideValue",
        .value = "Value",
    };
};
