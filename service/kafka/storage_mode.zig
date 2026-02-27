/// Controls storage mode for various supported storage tiers.
pub const StorageMode = enum {
    local,
    tiered,

    pub const json_field_names = .{
        .local = "LOCAL",
        .tiered = "TIERED",
    };
};
