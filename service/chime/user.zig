const AlexaForBusinessMetadata = @import("alexa_for_business_metadata.zig").AlexaForBusinessMetadata;
const License = @import("license.zig").License;
const InviteStatus = @import("invite_status.zig").InviteStatus;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;
const UserType = @import("user_type.zig").UserType;

/// The user on the Amazon Chime account.
pub const User = struct {
    /// The Amazon Chime account ID.
    account_id: ?[]const u8 = null,

    /// The Alexa for Business metadata.
    alexa_for_business_metadata: ?AlexaForBusinessMetadata = null,

    /// The display name of the user.
    display_name: ?[]const u8 = null,

    /// Date and time when the user is invited to the Amazon Chime account, in ISO
    /// 8601 format.
    invited_on: ?i64 = null,

    /// The license type for the user.
    license_type: ?License = null,

    /// The user's personal meeting PIN.
    personal_pin: ?[]const u8 = null,

    /// The primary email address of the user.
    primary_email: ?[]const u8 = null,

    /// The primary phone number associated with the user.
    primary_provisioned_number: ?[]const u8 = null,

    /// Date and time when the user is registered, in ISO 8601 format.
    registered_on: ?i64 = null,

    /// The user ID.
    user_id: []const u8,

    /// The user invite status.
    user_invitation_status: ?InviteStatus = null,

    /// The user registration status.
    user_registration_status: ?RegistrationStatus = null,

    /// The user type.
    user_type: ?UserType = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .alexa_for_business_metadata = "AlexaForBusinessMetadata",
        .display_name = "DisplayName",
        .invited_on = "InvitedOn",
        .license_type = "LicenseType",
        .personal_pin = "PersonalPIN",
        .primary_email = "PrimaryEmail",
        .primary_provisioned_number = "PrimaryProvisionedNumber",
        .registered_on = "RegisteredOn",
        .user_id = "UserId",
        .user_invitation_status = "UserInvitationStatus",
        .user_registration_status = "UserRegistrationStatus",
        .user_type = "UserType",
    };
};
