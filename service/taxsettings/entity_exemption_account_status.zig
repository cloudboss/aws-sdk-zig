pub const EntityExemptionAccountStatus = enum {
    none,
    valid,
    expired,
    pending,

    pub const json_field_names = .{
        .none = "None",
        .valid = "Valid",
        .expired = "Expired",
        .pending = "Pending",
    };
};
