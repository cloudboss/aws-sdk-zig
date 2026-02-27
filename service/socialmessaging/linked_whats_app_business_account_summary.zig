const WhatsAppBusinessAccountEventDestination = @import("whats_app_business_account_event_destination.zig").WhatsAppBusinessAccountEventDestination;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

/// The details of a linked WhatsApp Business Account.
pub const LinkedWhatsAppBusinessAccountSummary = struct {
    /// The ARN of the linked WhatsApp Business Account.
    arn: []const u8,

    /// The event destinations for the linked WhatsApp Business Account.
    event_destinations: []const WhatsAppBusinessAccountEventDestination,

    /// The ID of the linked WhatsApp Business Account, formatted as
    /// `waba-01234567890123456789012345678901`.
    id: []const u8,

    /// The date the WhatsApp Business Account was linked.
    link_date: i64,

    /// The registration status of the linked WhatsApp Business Account.
    registration_status: RegistrationStatus,

    /// The WhatsApp Business Account ID provided by Meta.
    waba_id: []const u8,

    /// The name of the linked WhatsApp Business Account.
    waba_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .event_destinations = "eventDestinations",
        .id = "id",
        .link_date = "linkDate",
        .registration_status = "registrationStatus",
        .waba_id = "wabaId",
        .waba_name = "wabaName",
    };
};
