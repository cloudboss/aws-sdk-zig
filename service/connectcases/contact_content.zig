/// An object that represents a content of an Amazon Connect contact object.
pub const ContactContent = struct {
    /// A list of channels to filter on for related items of type `Contact`.
    channel: []const u8,

    /// The difference between the `InitiationTimestamp` and the
    /// `DisconnectTimestamp` of the contact.
    connected_to_system_time: i64,

    /// A unique identifier of a contact in Amazon Connect.
    contact_arn: []const u8,

    pub const json_field_names = .{
        .channel = "channel",
        .connected_to_system_time = "connectedToSystemTime",
        .contact_arn = "contactArn",
    };
};
