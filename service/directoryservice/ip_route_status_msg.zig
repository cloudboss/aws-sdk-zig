pub const IpRouteStatusMsg = enum {
    adding,
    added,
    removing,
    removed,
    add_failed,
    remove_failed,

    pub const json_field_names = .{
        .adding = "ADDING",
        .added = "ADDED",
        .removing = "REMOVING",
        .removed = "REMOVED",
        .add_failed = "ADD_FAILED",
        .remove_failed = "REMOVE_FAILED",
    };
};
