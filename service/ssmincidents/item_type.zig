pub const ItemType = enum {
    analysis,
    incident,
    metric,
    parent,
    attachment,
    other,
    automation,
    involved_resource,
    task,

    pub const json_field_names = .{
        .analysis = "ANALYSIS",
        .incident = "INCIDENT",
        .metric = "METRIC",
        .parent = "PARENT",
        .attachment = "ATTACHMENT",
        .other = "OTHER",
        .automation = "AUTOMATION",
        .involved_resource = "INVOLVED_RESOURCE",
        .task = "TASK",
    };
};
