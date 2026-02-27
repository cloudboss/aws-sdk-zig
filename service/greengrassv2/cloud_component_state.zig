pub const CloudComponentState = enum {
    requested,
    initiated,
    deployable,
    failed,
    deprecated,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .initiated = "INITIATED",
        .deployable = "DEPLOYABLE",
        .failed = "FAILED",
        .deprecated = "DEPRECATED",
    };
};
