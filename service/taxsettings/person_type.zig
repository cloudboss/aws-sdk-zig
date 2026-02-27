pub const PersonType = enum {
    legal_person,
    physical_person,
    business,

    pub const json_field_names = .{
        .legal_person = "LEGAL_PERSON",
        .physical_person = "PHYSICAL_PERSON",
        .business = "BUSINESS",
    };
};
