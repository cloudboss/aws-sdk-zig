const InputLocation = @import("input_location.zig").InputLocation;

/// Static Key Settings
pub const StaticKeySettings = struct {
    /// The URL of the license server used for protecting content.
    key_provider_server: ?InputLocation,

    /// Static key value as a 32 character hexadecimal string.
    static_key_value: []const u8,

    pub const json_field_names = .{
        .key_provider_server = "KeyProviderServer",
        .static_key_value = "StaticKeyValue",
    };
};
