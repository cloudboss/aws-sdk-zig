pub const ResourceCategory = enum {
    compute,
    database,
    storage,
    code,
    ai_ml,
    identity,
    network,
    other,

    pub const json_field_names = .{
        .compute = "COMPUTE",
        .database = "DATABASE",
        .storage = "STORAGE",
        .code = "CODE",
        .ai_ml = "AI_ML",
        .identity = "IDENTITY",
        .network = "NETWORK",
        .other = "OTHER",
    };
};
