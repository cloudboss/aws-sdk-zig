pub const SyncConfigurationType = enum {
    cfn_stack_sync,

    pub const json_field_names = .{
        .cfn_stack_sync = "CFN_STACK_SYNC",
    };
};
