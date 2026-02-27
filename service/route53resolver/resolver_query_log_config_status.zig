pub const ResolverQueryLogConfigStatus = enum {
    creating,
    created,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .created = "Created",
        .deleting = "Deleting",
        .failed = "Failed",
    };
};
