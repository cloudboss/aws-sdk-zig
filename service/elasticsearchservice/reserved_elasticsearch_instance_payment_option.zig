pub const ReservedElasticsearchInstancePaymentOption = enum {
    all_upfront,
    partial_upfront,
    no_upfront,

    pub const json_field_names = .{
        .all_upfront = "ALL_UPFRONT",
        .partial_upfront = "PARTIAL_UPFRONT",
        .no_upfront = "NO_UPFRONT",
    };
};
