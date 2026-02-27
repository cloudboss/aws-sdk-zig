pub const RenewalEligibility = enum {
    eligible,
    ineligible,

    pub const json_field_names = .{
        .eligible = "ELIGIBLE",
        .ineligible = "INELIGIBLE",
    };
};
