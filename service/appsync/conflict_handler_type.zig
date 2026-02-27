pub const ConflictHandlerType = enum {
    optimistic_concurrency,
    lambda,
    automerge,
    none,

    pub const json_field_names = .{
        .optimistic_concurrency = "OPTIMISTIC_CONCURRENCY",
        .lambda = "LAMBDA",
        .automerge = "AUTOMERGE",
        .none = "NONE",
    };
};
