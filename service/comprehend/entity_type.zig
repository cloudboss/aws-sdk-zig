pub const EntityType = enum {
    person,
    location,
    organization,
    commercial_item,
    event,
    date,
    quantity,
    title,
    other,

    pub const json_field_names = .{
        .person = "PERSON",
        .location = "LOCATION",
        .organization = "ORGANIZATION",
        .commercial_item = "COMMERCIAL_ITEM",
        .event = "EVENT",
        .date = "DATE",
        .quantity = "QUANTITY",
        .title = "TITLE",
        .other = "OTHER",
    };
};
