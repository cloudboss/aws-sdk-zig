const aws = @import("aws");

/// A duplicate customer profile that is to be merged into a main profile.
pub const FieldSourceProfileIds = struct {
    /// A unique identifier for the account number field to be merged.
    account_number: ?[]const u8,

    /// A unique identifier for the additional information field to be merged.
    additional_information: ?[]const u8,

    /// A unique identifier for the party type field to be merged.
    address: ?[]const u8,

    /// A unique identifier for the attributes field to be merged.
    attributes: ?[]const aws.map.StringMapEntry,

    /// A unique identifier for the billing type field to be merged.
    billing_address: ?[]const u8,

    /// A unique identifier for the birthdate field to be merged.
    birth_date: ?[]const u8,

    /// A unique identifier for the party type field to be merged.
    business_email_address: ?[]const u8,

    /// A unique identifier for the business name field to be merged.
    business_name: ?[]const u8,

    /// A unique identifier for the business phone number field to be merged.
    business_phone_number: ?[]const u8,

    /// A unique identifier for the email address field to be merged.
    email_address: ?[]const u8,

    /// A unique identifier for the engagement preferences field to be merged.
    engagement_preferences: ?[]const u8,

    /// A unique identifier for the first name field to be merged.
    first_name: ?[]const u8,

    /// A unique identifier for the gender field to be merged.
    gender: ?[]const u8,

    /// A unique identifier for the home phone number field to be merged.
    home_phone_number: ?[]const u8,

    /// A unique identifier for the last name field to be merged.
    last_name: ?[]const u8,

    /// A unique identifier for the mailing address field to be merged.
    mailing_address: ?[]const u8,

    /// A unique identifier for the middle name field to be merged.
    middle_name: ?[]const u8,

    /// A unique identifier for the mobile phone number field to be merged.
    mobile_phone_number: ?[]const u8,

    /// A unique identifier for the party type field to be merged.
    party_type: ?[]const u8,

    /// A unique identifier for the personal email address field to be merged.
    personal_email_address: ?[]const u8,

    /// A unique identifier for the phone number field to be merged.
    phone_number: ?[]const u8,

    /// A unique identifier for the profile type field to be merged.
    profile_type: ?[]const u8,

    /// A unique identifier for the shipping address field to be merged.
    shipping_address: ?[]const u8,

    pub const json_field_names = .{
        .account_number = "AccountNumber",
        .additional_information = "AdditionalInformation",
        .address = "Address",
        .attributes = "Attributes",
        .billing_address = "BillingAddress",
        .birth_date = "BirthDate",
        .business_email_address = "BusinessEmailAddress",
        .business_name = "BusinessName",
        .business_phone_number = "BusinessPhoneNumber",
        .email_address = "EmailAddress",
        .engagement_preferences = "EngagementPreferences",
        .first_name = "FirstName",
        .gender = "Gender",
        .home_phone_number = "HomePhoneNumber",
        .last_name = "LastName",
        .mailing_address = "MailingAddress",
        .middle_name = "MiddleName",
        .mobile_phone_number = "MobilePhoneNumber",
        .party_type = "PartyType",
        .personal_email_address = "PersonalEmailAddress",
        .phone_number = "PhoneNumber",
        .profile_type = "ProfileType",
        .shipping_address = "ShippingAddress",
    };
};
