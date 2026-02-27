const WhatsAppBusinessAccountEventDestination = @import("whats_app_business_account_event_destination.zig").WhatsAppBusinessAccountEventDestination;
const WhatsAppPhoneNumberSummary = @import("whats_app_phone_number_summary.zig").WhatsAppPhoneNumberSummary;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

/// The details of your linked WhatsApp Business Account.
pub const LinkedWhatsAppBusinessAccount = struct {
    /// The ARN of the linked WhatsApp Business Account.
    arn: []const u8,

    /// The event destinations for the linked WhatsApp Business Account.
    event_destinations: []const WhatsAppBusinessAccountEventDestination,

    /// The ID of the linked WhatsApp Business Account, formatted as
    /// `waba-01234567890123456789012345678901`.
    id: []const u8,

    /// The date the WhatsApp Business Account was linked.
    link_date: i64,

    /// The phone numbers associated with the Linked WhatsApp Business Account.
    phone_numbers: []const WhatsAppPhoneNumberSummary,

    /// The registration status of the linked WhatsApp Business Account.
    registration_status: RegistrationStatus,

    /// The WhatsApp Business Account ID from meta.
    waba_id: []const u8,

    /// The name of the linked WhatsApp Business Account.
    waba_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .event_destinations = "eventDestinations",
        .id = "id",
        .link_date = "linkDate",
        .phone_numbers = "phoneNumbers",
        .registration_status = "registrationStatus",
        .waba_id = "wabaId",
        .waba_name = "wabaName",
    };
};
