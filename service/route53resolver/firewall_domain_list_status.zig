pub const FirewallDomainListStatus = enum {
    complete,
    complete_import_failed,
    importing,
    deleting,
    updating,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .complete_import_failed = "COMPLETE_IMPORT_FAILED",
        .importing = "IMPORTING",
        .deleting = "DELETING",
        .updating = "UPDATING",
    };
};
