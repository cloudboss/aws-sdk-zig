pub const TaxRegistrationStatus = enum {
    verified,
    pending,
    deleted,
    rejected,

    pub const json_field_names = .{
        .verified = "VERIFIED",
        .pending = "PENDING",
        .deleted = "DELETED",
        .rejected = "REJECTED",
    };
};
