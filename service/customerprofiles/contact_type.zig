pub const ContactType = enum {
    phone_number,
    mobile_phone_number,
    home_phone_number,
    business_phone_number,
    email_address,
    personal_email_address,
    business_email_address,

    pub const json_field_names = .{
        .phone_number = "PHONE_NUMBER",
        .mobile_phone_number = "MOBILE_PHONE_NUMBER",
        .home_phone_number = "HOME_PHONE_NUMBER",
        .business_phone_number = "BUSINESS_PHONE_NUMBER",
        .email_address = "EMAIL_ADDRESS",
        .personal_email_address = "PERSONAL_EMAIL_ADDRESS",
        .business_email_address = "BUSINESS_EMAIL_ADDRESS",
    };
};
