pub const SubscriptionRequestStatus = enum {
    pending,
    accepted,
    rejected,

    pub const json_field_names = .{
        .pending = "PENDING",
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
    };
};
