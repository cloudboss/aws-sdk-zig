pub const ConnectionState = enum {
    creating,
    updating,
    deleting,
    authorized,
    deauthorized,
    authorizing,
    deauthorizing,
    active,
    failed_connectivity,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .authorized = "AUTHORIZED",
        .deauthorized = "DEAUTHORIZED",
        .authorizing = "AUTHORIZING",
        .deauthorizing = "DEAUTHORIZING",
        .active = "ACTIVE",
        .failed_connectivity = "FAILED_CONNECTIVITY",
    };
};
