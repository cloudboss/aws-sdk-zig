/// The creation date and time, and name, of a security configuration.
pub const SecurityConfigurationSummary = struct {
    /// The date and time the security configuration was created.
    creation_date_time: ?i64 = null,

    /// The name of the security configuration.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .name = "Name",
    };
};
