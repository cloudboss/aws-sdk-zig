pub const VanityDomainStatus = enum {
    pending,
    approved,
    unapproved,

    pub const json_field_names = .{
        .pending = "PENDING",
        .approved = "APPROVED",
        .unapproved = "UNAPPROVED",
    };
};
