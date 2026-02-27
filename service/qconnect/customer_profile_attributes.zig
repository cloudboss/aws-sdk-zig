const aws = @import("aws");

/// The customer profile attributes that are used with the message template.
pub const CustomerProfileAttributes = struct {
    /// A unique account number that you have given to the customer.
    account_number: ?[]const u8,

    /// Any additional information relevant to the customer's profile.
    additional_information: ?[]const u8,

    /// The first line of a customer address.
    address_1: ?[]const u8,

    /// The second line of a customer address.
    address_2: ?[]const u8,

    /// The third line of a customer address.
    address_3: ?[]const u8,

    /// The fourth line of a customer address.
    address_4: ?[]const u8,

    /// The first line of a customer’s billing address.
    billing_address_1: ?[]const u8,

    /// The second line of a customer’s billing address.
    billing_address_2: ?[]const u8,

    /// The third line of a customer’s billing address.
    billing_address_3: ?[]const u8,

    /// The fourth line of a customer’s billing address.
    billing_address_4: ?[]const u8,

    /// The city of a customer’s billing address.
    billing_city: ?[]const u8,

    /// The country of a customer’s billing address.
    billing_country: ?[]const u8,

    /// The county of a customer’s billing address.
    billing_county: ?[]const u8,

    /// The postal code of a customer’s billing address.
    billing_postal_code: ?[]const u8,

    /// The province of a customer’s billing address.
    billing_province: ?[]const u8,

    /// The state of a customer’s billing address.
    billing_state: ?[]const u8,

    /// The customer's birth date.
    birth_date: ?[]const u8,

    /// The customer's business email address.
    business_email_address: ?[]const u8,

    /// The name of the customer's business.
    business_name: ?[]const u8,

    /// The customer's business phone number.
    business_phone_number: ?[]const u8,

    /// The city in which a customer lives.
    city: ?[]const u8,

    /// The country in which a customer lives.
    country: ?[]const u8,

    /// The county in which a customer lives.
    county: ?[]const u8,

    /// The custom attributes in customer profile attributes.
    custom: ?[]const aws.map.StringMapEntry,

    /// The customer's email address, which has not been specified as a personal or
    /// business address.
    email_address: ?[]const u8,

    /// The customer's first name.
    first_name: ?[]const u8,

    /// The customer's gender.
    gender: ?[]const u8,

    /// The customer's mobile phone number.
    home_phone_number: ?[]const u8,

    /// The customer's last name.
    last_name: ?[]const u8,

    /// The first line of a customer’s mailing address.
    mailing_address_1: ?[]const u8,

    /// The second line of a customer’s mailing address.
    mailing_address_2: ?[]const u8,

    /// The third line of a customer’s mailing address.
    mailing_address_3: ?[]const u8,

    /// The fourth line of a customer’s mailing address.
    mailing_address_4: ?[]const u8,

    /// The city of a customer’s mailing address.
    mailing_city: ?[]const u8,

    /// The country of a customer’s mailing address.
    mailing_country: ?[]const u8,

    /// The county of a customer’s mailing address.
    mailing_county: ?[]const u8,

    /// The postal code of a customer’s mailing address.
    mailing_postal_code: ?[]const u8,

    /// The province of a customer’s mailing address.
    mailing_province: ?[]const u8,

    /// The state of a customer’s mailing address.
    mailing_state: ?[]const u8,

    /// The customer's middle name.
    middle_name: ?[]const u8,

    /// The customer's mobile phone number.
    mobile_phone_number: ?[]const u8,

    /// The customer's party type.
    party_type: ?[]const u8,

    /// The customer's phone number, which has not been specified as a mobile, home,
    /// or business number.
    phone_number: ?[]const u8,

    /// The postal code of a customer address.
    postal_code: ?[]const u8,

    /// The ARN of a customer profile.
    profile_arn: ?[]const u8,

    /// The unique identifier of a customer profile.
    profile_id: ?[]const u8,

    /// The province in which a customer lives.
    province: ?[]const u8,

    /// The first line of a customer’s shipping address.
    shipping_address_1: ?[]const u8,

    /// The second line of a customer’s shipping address.
    shipping_address_2: ?[]const u8,

    /// The third line of a customer’s shipping address.
    shipping_address_3: ?[]const u8,

    /// The fourth line of a customer’s shipping address.
    shipping_address_4: ?[]const u8,

    /// The city of a customer’s shipping address.
    shipping_city: ?[]const u8,

    /// The country of a customer’s shipping address.
    shipping_country: ?[]const u8,

    /// The county of a customer’s shipping address.
    shipping_county: ?[]const u8,

    /// The postal code of a customer’s shipping address.
    shipping_postal_code: ?[]const u8,

    /// The province of a customer’s shipping address.
    shipping_province: ?[]const u8,

    /// The state of a customer’s shipping address.
    shipping_state: ?[]const u8,

    /// The state in which a customer lives.
    state: ?[]const u8,

    pub const json_field_names = .{
        .account_number = "accountNumber",
        .additional_information = "additionalInformation",
        .address_1 = "address1",
        .address_2 = "address2",
        .address_3 = "address3",
        .address_4 = "address4",
        .billing_address_1 = "billingAddress1",
        .billing_address_2 = "billingAddress2",
        .billing_address_3 = "billingAddress3",
        .billing_address_4 = "billingAddress4",
        .billing_city = "billingCity",
        .billing_country = "billingCountry",
        .billing_county = "billingCounty",
        .billing_postal_code = "billingPostalCode",
        .billing_province = "billingProvince",
        .billing_state = "billingState",
        .birth_date = "birthDate",
        .business_email_address = "businessEmailAddress",
        .business_name = "businessName",
        .business_phone_number = "businessPhoneNumber",
        .city = "city",
        .country = "country",
        .county = "county",
        .custom = "custom",
        .email_address = "emailAddress",
        .first_name = "firstName",
        .gender = "gender",
        .home_phone_number = "homePhoneNumber",
        .last_name = "lastName",
        .mailing_address_1 = "mailingAddress1",
        .mailing_address_2 = "mailingAddress2",
        .mailing_address_3 = "mailingAddress3",
        .mailing_address_4 = "mailingAddress4",
        .mailing_city = "mailingCity",
        .mailing_country = "mailingCountry",
        .mailing_county = "mailingCounty",
        .mailing_postal_code = "mailingPostalCode",
        .mailing_province = "mailingProvince",
        .mailing_state = "mailingState",
        .middle_name = "middleName",
        .mobile_phone_number = "mobilePhoneNumber",
        .party_type = "partyType",
        .phone_number = "phoneNumber",
        .postal_code = "postalCode",
        .profile_arn = "profileARN",
        .profile_id = "profileId",
        .province = "province",
        .shipping_address_1 = "shippingAddress1",
        .shipping_address_2 = "shippingAddress2",
        .shipping_address_3 = "shippingAddress3",
        .shipping_address_4 = "shippingAddress4",
        .shipping_city = "shippingCity",
        .shipping_country = "shippingCountry",
        .shipping_county = "shippingCounty",
        .shipping_postal_code = "shippingPostalCode",
        .shipping_province = "shippingProvince",
        .shipping_state = "shippingState",
        .state = "state",
    };
};
