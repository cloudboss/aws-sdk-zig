const WhatsAppBusinessAccountEventDestination = @import("whats_app_business_account_event_destination.zig").WhatsAppBusinessAccountEventDestination;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

/// The details of a linked WhatsApp Business Account.
pub const LinkedWhatsAppBusinessAccountSummary = struct {
    /// The ARN of the linked WhatsApp Business Account.
    arn: []const u8,

    /// The Meta Conversions API dataset ID associated with this WhatsApp Business
    /// Account. This value is a numeric string of 10 to 20 digits. This field is
    /// not present when no dataset has been created for this account.
    dataset_id: ?[]const u8 = null,

    /// The event destinations for the linked WhatsApp Business Account.
    event_destinations: []const WhatsAppBusinessAccountEventDestination,

    /// The ID of the linked WhatsApp Business Account, formatted as
    /// `waba-01234567890123456789012345678901`.
    id: []const u8,

    /// The date the WhatsApp Business Account was linked.
    link_date: i64,

    /// The onboarding status for the Marketing Messages API. This value is fetched
    /// from Meta and indicates whether the WhatsApp Business Account is onboarded
    /// for Meta's Marketing Messages API.
    marketing_messages_onboarding_status: ?[]const u8 = null,

    /// The registration status of the linked WhatsApp Business Account.
    registration_status: RegistrationStatus,

    /// The WhatsApp Business Account ID provided by Meta.
    waba_id: []const u8,

    /// The name of the linked WhatsApp Business Account.
    waba_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .dataset_id = "datasetId",
        .event_destinations = "eventDestinations",
        .id = "id",
        .link_date = "linkDate",
        .marketing_messages_onboarding_status = "marketingMessagesOnboardingStatus",
        .registration_status = "registrationStatus",
        .waba_id = "wabaId",
        .waba_name = "wabaName",
    };
};
