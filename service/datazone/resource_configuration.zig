const aws = @import("aws");

/// The details of the resource configuration.
pub const ResourceConfiguration = struct {
    /// The description of the resource configuration.
    description: ?[]const u8 = null,

    /// The identifier of the resource configuration.
    identifier: []const u8,

    /// The name of the resource configuration.
    name: []const u8,

    /// The parameters of the resource configuration.
    parameters: []const aws.map.StringMapEntry,

    /// The Amazon Web Services Region of the resource configuration.
    region: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .identifier = "identifier",
        .name = "name",
        .parameters = "parameters",
        .region = "region",
    };
};
