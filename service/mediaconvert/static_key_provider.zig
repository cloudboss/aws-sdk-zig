/// Use these settings to set up encryption with a static key provider.
pub const StaticKeyProvider = struct {
    /// Relates to DRM implementation. Sets the value of the KEYFORMAT attribute.
    /// Must be 'identity' or a reverse DNS string. May be omitted to indicate an
    /// implicit value of 'identity'.
    key_format: ?[]const u8 = null,

    /// Relates to DRM implementation. Either a single positive integer version
    /// value or a slash delimited list of version values (1/2/3).
    key_format_versions: ?[]const u8 = null,

    /// Relates to DRM implementation. Use a 32-character hexidecimal string to
    /// specify Key Value.
    static_key_value: ?[]const u8 = null,

    /// Relates to DRM implementation. The location of the license server used for
    /// protecting content.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_format = "KeyFormat",
        .key_format_versions = "KeyFormatVersions",
        .static_key_value = "StaticKeyValue",
        .url = "Url",
    };
};
