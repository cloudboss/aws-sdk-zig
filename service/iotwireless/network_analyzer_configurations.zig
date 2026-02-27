/// Network analyzer configurations.
pub const NetworkAnalyzerConfigurations = struct {
    /// The Amazon Resource Name of the new resource.
    arn: ?[]const u8,

    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
