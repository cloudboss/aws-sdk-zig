pub const DeleteSecurityConfigurationRequest = struct {
    /// The ID of the security configuration to delete.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
