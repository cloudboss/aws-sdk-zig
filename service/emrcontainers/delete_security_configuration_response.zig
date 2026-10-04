pub const DeleteSecurityConfigurationResponse = struct {
    /// The ID of the deleted security configuration.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
    };
};
