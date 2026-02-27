/// Information about an HTTP URL destination.
pub const HttpUrlDestinationSummary = struct {
    /// The URL used to confirm ownership of or access to the HTTP topic rule
    /// destination
    /// URL.
    confirmation_url: ?[]const u8,

    pub const json_field_names = .{
        .confirmation_url = "confirmationUrl",
    };
};
