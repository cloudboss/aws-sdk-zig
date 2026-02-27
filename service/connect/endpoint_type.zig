pub const EndpointType = enum {
    telephone_number,
    voip,
    contact_flow,
    connect_phonenumber_arn,
    email_address,

    pub const json_field_names = .{
        .telephone_number = "TELEPHONE_NUMBER",
        .voip = "VOIP",
        .contact_flow = "CONTACT_FLOW",
        .connect_phonenumber_arn = "CONNECT_PHONENUMBER_ARN",
        .email_address = "EMAIL_ADDRESS",
    };
};
