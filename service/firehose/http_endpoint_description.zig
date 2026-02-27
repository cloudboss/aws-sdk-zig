/// Describes the HTTP endpoint selected as the destination.
pub const HttpEndpointDescription = struct {
    /// The name of the HTTP endpoint selected as the destination.
    name: ?[]const u8,

    /// The URL of the HTTP endpoint selected as the destination.
    url: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .url = "Url",
    };
};
