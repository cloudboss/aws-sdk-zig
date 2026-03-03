const aws = @import("aws");

const Address = @import("address.zig").Address;
const EngagementPreferences = @import("engagement_preferences.zig").EngagementPreferences;
const FoundByKeyValue = @import("found_by_key_value.zig").FoundByKeyValue;
const Gender = @import("gender.zig").Gender;
const PartyType = @import("party_type.zig").PartyType;
const ProfileType = @import("profile_type.zig").ProfileType;

/// The standard profile of a customer.
pub const Profile = struct {
    /// An account number that you have assigned to the customer.
    account_number: ?[]const u8 = null,

    /// Any additional information relevant to the customer’s profile.
    additional_information: ?[]const u8 = null,

    /// A generic address associated with the customer that is not mailing,
    /// shipping, or
    /// billing.
    address: ?Address = null,

    /// A key value pair of attributes of a customer profile.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The customer’s billing address.
    billing_address: ?Address = null,

    /// The customer’s birth date.
    birth_date: ?[]const u8 = null,

    /// The customer’s business email address.
    business_email_address: ?[]const u8 = null,

    /// The name of the customer’s business.
    business_name: ?[]const u8 = null,

    /// The customer’s home phone number.
    business_phone_number: ?[]const u8 = null,

    /// The customer’s email address, which has not been specified as a personal or
    /// business
    /// address.
    email_address: ?[]const u8 = null,

    /// The customer or account’s engagement preferences.
    engagement_preferences: ?EngagementPreferences = null,

    /// The customer’s first name.
    first_name: ?[]const u8 = null,

    /// A list of items used to find a profile returned in a
    /// [SearchProfiles](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_SearchProfiles.html) response.
    /// An item is a key-value(s) pair that matches an attribute in the profile.
    ///
    /// If the optional `AdditionalSearchKeys` parameter was included in the
    /// [SearchProfiles](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_SearchProfiles.html) request, the `FoundByItems` list should be interpreted
    /// based on the `LogicalOperator` used in the request:
    ///
    /// * `AND` - The profile included in the response matched all of the search
    /// keys specified in the request. The `FoundByItems` will include all of the
    /// key-value(s) pairs that were specified in the request (as this is a
    /// requirement of
    /// `AND` search logic).
    ///
    /// * `OR` - The profile included in the response matched at least one of the
    /// search keys specified in the request. The `FoundByItems` will include each
    /// of the key-value(s) pairs that the profile was found by.
    ///
    /// The `OR` relationship is the default behavior if the
    /// `LogicalOperator` parameter is not included in the
    /// [SearchProfiles](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_SearchProfiles.html)
    /// request.
    found_by_items: ?[]const FoundByKeyValue = null,

    /// The gender with which the customer identifies.
    gender: ?Gender = null,

    /// An alternative to Gender which accepts any string as input.
    gender_string: ?[]const u8 = null,

    /// The customer’s home phone number.
    home_phone_number: ?[]const u8 = null,

    /// The customer’s last name.
    last_name: ?[]const u8 = null,

    /// The customer’s mailing address.
    mailing_address: ?Address = null,

    /// The customer’s middle name.
    middle_name: ?[]const u8 = null,

    /// The customer’s mobile phone number.
    mobile_phone_number: ?[]const u8 = null,

    /// The type of profile used to describe the customer.
    party_type: ?PartyType = null,

    /// An alternative to PartyType which accepts any string as input.
    party_type_string: ?[]const u8 = null,

    /// The customer’s personal email address.
    personal_email_address: ?[]const u8 = null,

    /// The customer's phone number, which has not been specified as a mobile, home,
    /// or business
    /// number.
    phone_number: ?[]const u8 = null,

    /// The unique identifier of a customer profile.
    profile_id: ?[]const u8 = null,

    /// The type of the profile.
    profile_type: ?ProfileType = null,

    /// The customer’s shipping address.
    shipping_address: ?Address = null,

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
        .found_by_items = "FoundByItems",
        .gender = "Gender",
        .gender_string = "GenderString",
        .home_phone_number = "HomePhoneNumber",
        .last_name = "LastName",
        .mailing_address = "MailingAddress",
        .middle_name = "MiddleName",
        .mobile_phone_number = "MobilePhoneNumber",
        .party_type = "PartyType",
        .party_type_string = "PartyTypeString",
        .personal_email_address = "PersonalEmailAddress",
        .phone_number = "PhoneNumber",
        .profile_id = "ProfileId",
        .profile_type = "ProfileType",
        .shipping_address = "ShippingAddress",
    };
};
