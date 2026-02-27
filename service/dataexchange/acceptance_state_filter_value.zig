pub const AcceptanceStateFilterValue = enum {
    pending_receiver_acceptance,
    accepted,

    pub const json_field_names = .{
        .pending_receiver_acceptance = "PENDING_RECEIVER_ACCEPTANCE",
        .accepted = "ACCEPTED",
    };
};
