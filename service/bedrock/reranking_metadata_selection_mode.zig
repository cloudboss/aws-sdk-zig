pub const RerankingMetadataSelectionMode = enum {
    selective,
    all,

    pub const json_field_names = .{
        .selective = "SELECTIVE",
        .all = "ALL",
    };
};
