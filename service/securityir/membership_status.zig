pub const MembershipStatus = enum {
    active,
    cancelled,
    terminated,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .cancelled = "CANCELLED",
        .terminated = "TERMINATED",
    };
};
