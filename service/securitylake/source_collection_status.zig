pub const SourceCollectionStatus = enum {
    collecting,
    misconfigured,
    not_collecting,

    pub const json_field_names = .{
        .collecting = "COLLECTING",
        .misconfigured = "MISCONFIGURED",
        .not_collecting = "NOT_COLLECTING",
    };
};
