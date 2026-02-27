/// HTTP URL destination configuration used by the topic rule's HTTP action.
pub const HttpUrlDestinationConfiguration = struct {
    /// The URL IoT uses to confirm ownership of or access to the topic rule
    /// destination
    /// URL.
    confirmation_url: []const u8,

    pub const json_field_names = .{
        .confirmation_url = "confirmationUrl",
    };
};
