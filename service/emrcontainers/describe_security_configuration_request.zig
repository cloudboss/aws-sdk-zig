pub const DescribeSecurityConfigurationRequest = struct {
    /// The ID of the security configuration.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
