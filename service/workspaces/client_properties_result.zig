const ClientProperties = @import("client_properties.zig").ClientProperties;

/// Information about the Amazon WorkSpaces client.
pub const ClientPropertiesResult = struct {
    /// Information about the Amazon WorkSpaces client.
    client_properties: ?ClientProperties = null,

    /// The resource identifier, in the form of a directory ID.
    resource_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_properties = "ClientProperties",
        .resource_id = "ResourceId",
    };
};
