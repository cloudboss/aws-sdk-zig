/// Contains a Neptune ML configuration.
pub const MlConfigDefinition = struct {
    /// The ARN for the configuration.
    arn: ?[]const u8 = null,

    /// The configuration name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};
