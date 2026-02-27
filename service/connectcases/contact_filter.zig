/// A filter for related items of type `Contact`.
pub const ContactFilter = struct {
    /// A list of channels to filter on for related items of type `Contact`.
    channel: ?[]const []const u8,

    /// A unique identifier of a contact in Amazon Connect.
    contact_arn: ?[]const u8,

    pub const json_field_names = .{
        .channel = "channel",
        .contact_arn = "contactArn",
    };
};
