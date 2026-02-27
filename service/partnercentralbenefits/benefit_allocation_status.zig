pub const BenefitAllocationStatus = enum {
    active,
    inactive,
    fulfilled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .fulfilled = "FULFILLED",
    };
};
