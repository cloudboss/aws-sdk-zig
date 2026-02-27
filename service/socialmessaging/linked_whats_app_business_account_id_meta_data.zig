const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;
const WhatsAppPhoneNumberDetail = @import("whats_app_phone_number_detail.zig").WhatsAppPhoneNumberDetail;

/// Contains your WhatsApp registration status and details of any unregistered
/// WhatsApp
/// phone number.
pub const LinkedWhatsAppBusinessAccountIdMetaData = struct {
    /// The name of your account.
    account_name: ?[]const u8,

    /// The registration status of the linked WhatsApp Business Account.
    registration_status: ?RegistrationStatus,

    /// The details for unregistered WhatsApp phone numbers.
    unregistered_whats_app_phone_numbers: ?[]const WhatsAppPhoneNumberDetail,

    /// The Amazon Resource Name (ARN) of the WhatsApp Business Account ID.
    waba_id: ?[]const u8,

    pub const json_field_names = .{
        .account_name = "accountName",
        .registration_status = "registrationStatus",
        .unregistered_whats_app_phone_numbers = "unregisteredWhatsAppPhoneNumbers",
        .waba_id = "wabaId",
    };
};
