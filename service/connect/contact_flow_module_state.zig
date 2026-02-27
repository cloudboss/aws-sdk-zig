pub const ContactFlowModuleState = enum {
    active,
    archived,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .archived = "ARCHIVED",
    };
};
