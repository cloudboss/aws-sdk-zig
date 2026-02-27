pub const ConnectionState = enum {
    creating,
    updating,
    deleting,
    authorized,
    deauthorized,
    authorizing,
    deauthorizing,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .authorized = "AUTHORIZED",
        .deauthorized = "DEAUTHORIZED",
        .authorizing = "AUTHORIZING",
        .deauthorizing = "DEAUTHORIZING",
    };
};
