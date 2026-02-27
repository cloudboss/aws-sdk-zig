pub const IdentityStatus = enum {
    pending,
    accepted,
    rejected,
    invalid,

    pub const json_field_names = .{
        .pending = "PENDING",
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
        .invalid = "INVALID",
    };
};
