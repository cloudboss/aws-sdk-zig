pub const PricingUnit = enum {
    gb,
    hrs,
    gb_mo,
    bundles,
    queries,

    pub const json_field_names = .{
        .gb = "GB",
        .hrs = "Hrs",
        .gb_mo = "GBMo",
        .bundles = "Bundles",
        .queries = "Queries",
    };
};
