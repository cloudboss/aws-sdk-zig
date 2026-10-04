const aws = @import("aws");

/// The resource configuration that is used to configure the environment
/// blueprint.
pub const PutResourceConfiguration = struct {
    /// The description of the resource configuration.
    description: ?[]const u8 = null,

    /// The name of the resource configuration.
    name: []const u8,

    /// The parameters of the resource configuration.
    parameters: []const aws.map.StringMapEntry,

    /// The Amazon Web Services Region of the resource configuration.
    region: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .parameters = "parameters",
        .region = "region",
    };
};
