pub const EntityType = enum {
    device,
    service,
    device_model,
    capability,
    state,
    action,
    event,
    property,
    mapping,
    @"enum",

    pub const json_field_names = .{
        .device = "DEVICE",
        .service = "SERVICE",
        .device_model = "DEVICE_MODEL",
        .capability = "CAPABILITY",
        .state = "STATE",
        .action = "ACTION",
        .event = "EVENT",
        .property = "PROPERTY",
        .mapping = "MAPPING",
        .@"enum" = "ENUM",
    };
};
