pub const ConflictResolutionStrategyTypeEnum = enum {
    none,
    accept_source,
    accept_destination,
    automerge,

    pub const json_field_names = .{
        .none = "NONE",
        .accept_source = "ACCEPT_SOURCE",
        .accept_destination = "ACCEPT_DESTINATION",
        .automerge = "AUTOMERGE",
    };
};
