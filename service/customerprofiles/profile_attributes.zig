const aws = @import("aws");

const ProfileDimension = @import("profile_dimension.zig").ProfileDimension;
const ExtraLengthValueProfileDimension = @import("extra_length_value_profile_dimension.zig").ExtraLengthValueProfileDimension;
const AddressDimension = @import("address_dimension.zig").AddressDimension;
const AttributeDimension = @import("attribute_dimension.zig").AttributeDimension;
const DateDimension = @import("date_dimension.zig").DateDimension;
const ProfileTypeDimension = @import("profile_type_dimension.zig").ProfileTypeDimension;

/// The object used to segment on attributes within the customer profile.
pub const ProfileAttributes = struct {
    /// A field to describe values to segment on within account number.
    account_number: ?ProfileDimension,

    /// A field to describe values to segment on within additional information.
    additional_information: ?ExtraLengthValueProfileDimension,

    /// A field to describe values to segment on within address.
    address: ?AddressDimension,

    /// A field to describe values to segment on within attributes.
    attributes: ?[]const aws.map.MapEntry(AttributeDimension),

    /// A field to describe values to segment on within billing address.
    billing_address: ?AddressDimension,

    /// A field to describe values to segment on within birthDate.
    birth_date: ?DateDimension,

    /// A field to describe values to segment on within business email address.
    business_email_address: ?ProfileDimension,

    /// A field to describe values to segment on within business name.
    business_name: ?ProfileDimension,

    /// A field to describe values to segment on within business phone number.
    business_phone_number: ?ProfileDimension,

    /// A field to describe values to segment on within email address.
    email_address: ?ProfileDimension,

    /// A field to describe values to segment on within first name.
    first_name: ?ProfileDimension,

    /// A field to describe values to segment on within genderString.
    gender_string: ?ProfileDimension,

    /// A field to describe values to segment on within home phone number.
    home_phone_number: ?ProfileDimension,

    /// A field to describe values to segment on within last name.
    last_name: ?ProfileDimension,

    /// A field to describe values to segment on within mailing address.
    mailing_address: ?AddressDimension,

    /// A field to describe values to segment on within middle name.
    middle_name: ?ProfileDimension,

    /// A field to describe values to segment on within mobile phone number.
    mobile_phone_number: ?ProfileDimension,

    /// A field to describe values to segment on within partyTypeString.
    party_type_string: ?ProfileDimension,

    /// A field to describe values to segment on within personal email address.
    personal_email_address: ?ProfileDimension,

    /// A field to describe values to segment on within phone number.
    phone_number: ?ProfileDimension,

    /// A field to describe values to segment on within profile type.
    profile_type: ?ProfileTypeDimension,

    /// A field to describe values to segment on within shipping address.
    shipping_address: ?AddressDimension,

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
        .first_name = "FirstName",
        .gender_string = "GenderString",
        .home_phone_number = "HomePhoneNumber",
        .last_name = "LastName",
        .mailing_address = "MailingAddress",
        .middle_name = "MiddleName",
        .mobile_phone_number = "MobilePhoneNumber",
        .party_type_string = "PartyTypeString",
        .personal_email_address = "PersonalEmailAddress",
        .phone_number = "PhoneNumber",
        .profile_type = "ProfileType",
        .shipping_address = "ShippingAddress",
    };
};
