pub const CreateSecurityConfigurationResponse = struct {
    /// The ARN (Amazon Resource Name) of the security configuration.
    arn: ?[]const u8,

    /// The ID of the security configuration.
    id: ?[]const u8,

    /// The name of the security configuration.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .name = "name",
    };
};
