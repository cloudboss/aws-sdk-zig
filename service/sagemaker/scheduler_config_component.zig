pub const SchedulerConfigComponent = enum {
    priority_classes,
    fair_share,
    idle_resource_sharing,

    pub const json_field_names = .{
        .priority_classes = "PRIORITY_CLASSES",
        .fair_share = "FAIR_SHARE",
        .idle_resource_sharing = "IDLE_RESOURCE_SHARING",
    };
};
