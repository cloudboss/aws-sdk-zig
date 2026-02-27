/// Describes an Amazon Connect client add-in.
pub const ConnectClientAddIn = struct {
    /// The client add-in identifier.
    add_in_id: ?[]const u8,

    /// The name of the client add in.
    name: ?[]const u8,

    /// The directory identifier for which the client add-in is configured.
    resource_id: ?[]const u8,

    /// The endpoint URL of the client add-in.
    url: ?[]const u8,

    pub const json_field_names = .{
        .add_in_id = "AddInId",
        .name = "Name",
        .resource_id = "ResourceId",
        .url = "URL",
    };
};
