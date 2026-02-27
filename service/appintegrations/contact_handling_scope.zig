pub const ContactHandlingScope = enum {
    cross_contacts,
    per_contact,

    pub const json_field_names = .{
        .cross_contacts = "CROSS_CONTACTS",
        .per_contact = "PER_CONTACT",
    };
};
