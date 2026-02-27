/// State capabilities added for the managed thing.
pub const StateCapability = struct {
    /// The id of the managed thing in the capability report.
    id: []const u8,

    /// Name for the Amazon Web Services capability.
    name: []const u8,

    /// Describe the command capability with the properties it supports.
    properties: ?[]const u8,

    /// Version for the Amazon Web Services capability.
    version: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .properties = "properties",
        .version = "version",
    };
};
