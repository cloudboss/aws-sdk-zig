/// Type of the DataAutomationProject
pub const DataAutomationProjectType = enum {
    async,
    sync,

    pub const json_field_names = .{
        .async = "ASYNC",
        .sync = "SYNC",
    };
};
