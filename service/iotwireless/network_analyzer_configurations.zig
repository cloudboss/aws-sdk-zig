/// Network analyzer configurations.
pub const NetworkAnalyzerConfigurations = struct {
    /// The Amazon Resource Name of the new resource.
    arn: ?[]const u8 = null,

    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
