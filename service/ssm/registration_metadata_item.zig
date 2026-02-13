/// Reserved for internal use.
pub const RegistrationMetadataItem = struct {
    /// Reserved for internal use.
    key: []const u8,

    /// Reserved for internal use.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
