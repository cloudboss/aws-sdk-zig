/// License asset group property.
pub const LicenseAssetGroupProperty = struct {
    /// Property key.
    key: []const u8,

    /// Property value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
