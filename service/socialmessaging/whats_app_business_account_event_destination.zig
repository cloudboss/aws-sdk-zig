/// Contains information on the event destination.
pub const WhatsAppBusinessAccountEventDestination = struct {
    /// The ARN of the event destination.
    event_destination_arn: []const u8,

    /// The Amazon Resource Name (ARN) of an Identity and Access Management role
    /// that is able to import phone numbers and write events.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_destination_arn = "eventDestinationArn",
        .role_arn = "roleArn",
    };
};
