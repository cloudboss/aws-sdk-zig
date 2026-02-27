pub const ResolverRuleStatus = enum {
    complete,
    deleting,
    updating,
    failed,

    pub const json_field_names = .{
        .complete = "Complete",
        .deleting = "Deleting",
        .updating = "Updating",
        .failed = "Failed",
    };
};
