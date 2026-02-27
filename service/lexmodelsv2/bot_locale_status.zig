pub const BotLocaleStatus = enum {
    creating,
    building,
    built,
    ready_express_testing,
    failed,
    deleting,
    not_built,
    importing,
    processing,

    pub const json_field_names = .{
        .creating = "Creating",
        .building = "Building",
        .built = "Built",
        .ready_express_testing = "ReadyExpressTesting",
        .failed = "Failed",
        .deleting = "Deleting",
        .not_built = "NotBuilt",
        .importing = "Importing",
        .processing = "Processing",
    };
};
