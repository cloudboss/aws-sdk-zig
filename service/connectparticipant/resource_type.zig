pub const ResourceType = enum {
    contact,
    contact_flow,
    instance,
    participant,
    hierarchy_level,
    hierarchy_group,
    user,
    phone_number,

    pub const json_field_names = .{
        .contact = "CONTACT",
        .contact_flow = "CONTACT_FLOW",
        .instance = "INSTANCE",
        .participant = "PARTICIPANT",
        .hierarchy_level = "HIERARCHY_LEVEL",
        .hierarchy_group = "HIERARCHY_GROUP",
        .user = "USER",
        .phone_number = "PHONE_NUMBER",
    };
};
