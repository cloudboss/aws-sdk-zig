pub const RecordTypeCode = enum {
    firm,
    general,
    high_rise,
    post_office_box,
    rural,
    street,

    pub const json_field_names = .{
        .firm = "FIRM",
        .general = "GENERAL",
        .high_rise = "HIGH_RISE",
        .post_office_box = "POST_OFFICE_BOX",
        .rural = "RURAL",
        .street = "STREET",
    };
};
