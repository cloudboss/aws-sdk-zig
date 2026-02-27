pub const MemberType = enum {
    dashboard,
    analysis,
    dataset,
    datasource,
    topic,

    pub const json_field_names = .{
        .dashboard = "DASHBOARD",
        .analysis = "ANALYSIS",
        .dataset = "DATASET",
        .datasource = "DATASOURCE",
        .topic = "TOPIC",
    };
};
