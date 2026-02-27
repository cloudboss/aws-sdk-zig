/// Offering type, e.g. 'NO_UPFRONT'
pub const OfferingType = enum {
    no_upfront,

    pub const json_field_names = .{
        .no_upfront = "NO_UPFRONT",
    };
};
