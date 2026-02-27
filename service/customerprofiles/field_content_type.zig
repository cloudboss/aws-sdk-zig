pub const FieldContentType = enum {
    string,
    number,
    phone_number,
    email_address,
    name,

    pub const json_field_names = .{
        .string = "STRING",
        .number = "NUMBER",
        .phone_number = "PHONE_NUMBER",
        .email_address = "EMAIL_ADDRESS",
        .name = "NAME",
    };
};
