pub const MaximumSupportedWeightLbs = enum {
    no_limit,
    max_1400_lbs,
    max_1600_lbs,
    max_1800_lbs,
    max_2000_lbs,

    pub const json_field_names = .{
        .no_limit = "NO_LIMIT",
        .max_1400_lbs = "MAX_1400_LBS",
        .max_1600_lbs = "MAX_1600_LBS",
        .max_1800_lbs = "MAX_1800_LBS",
        .max_2000_lbs = "MAX_2000_LBS",
    };
};
