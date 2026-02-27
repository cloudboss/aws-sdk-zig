const Channel = @import("channel.zig").Channel;
const ContactInitiationMethod = @import("contact_initiation_method.zig").ContactInitiationMethod;

/// Contact summary of a contact in contact tree associated with unique
/// identifier.
pub const AssociatedContactSummary = struct {
    /// How the contact reached your contact center.
    channel: ?Channel,

    /// The Amazon Resource Name (ARN) of the contact
    contact_arn: ?[]const u8,

    /// The identifier of the contact in this instance of Amazon Connect.
    contact_id: ?[]const u8,

    /// The date and time that the customer endpoint disconnected from the current
    /// contact, in UTC time. In transfer
    /// scenarios, the DisconnectTimestamp of the previous contact indicates the
    /// date and time when that contact
    /// ended.
    disconnect_timestamp: ?i64,

    /// If this contact is related to other contacts, this is the ID of the initial
    /// contact.
    initial_contact_id: ?[]const u8,

    /// Indicates how the contact was initiated.
    initiation_method: ?ContactInitiationMethod,

    /// The date and time this contact was initiated, in UTC time.
    initiation_timestamp: ?i64,

    /// If this contact is not the first contact, this is the ID of the previous
    /// contact.
    previous_contact_id: ?[]const u8,

    /// The contactId that is related to this contact.
    related_contact_id: ?[]const u8,

    pub const json_field_names = .{
        .channel = "Channel",
        .contact_arn = "ContactArn",
        .contact_id = "ContactId",
        .disconnect_timestamp = "DisconnectTimestamp",
        .initial_contact_id = "InitialContactId",
        .initiation_method = "InitiationMethod",
        .initiation_timestamp = "InitiationTimestamp",
        .previous_contact_id = "PreviousContactId",
        .related_contact_id = "RelatedContactId",
    };
};
