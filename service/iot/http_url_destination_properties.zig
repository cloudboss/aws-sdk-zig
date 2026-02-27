/// HTTP URL destination properties.
pub const HttpUrlDestinationProperties = struct {
    /// The URL used to confirm the HTTP topic rule destination URL.
    confirmation_url: ?[]const u8,

    pub const json_field_names = .{
        .confirmation_url = "confirmationUrl",
    };
};
