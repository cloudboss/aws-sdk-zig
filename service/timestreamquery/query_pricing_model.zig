pub const QueryPricingModel = enum {
    bytes_scanned,
    compute_units,

    pub const json_field_names = .{
        .bytes_scanned = "BYTES_SCANNED",
        .compute_units = "COMPUTE_UNITS",
    };
};
