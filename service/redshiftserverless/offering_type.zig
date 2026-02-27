pub const OfferingType = enum {
    all_upfront,
    no_upfront,

    pub const json_field_names = .{
        .all_upfront = "ALL_UPFRONT",
        .no_upfront = "NO_UPFRONT",
    };
};
