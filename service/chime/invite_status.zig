pub const InviteStatus = enum {
    pending,
    accepted,
    failed,

    pub const json_field_names = .{
        .pending = "Pending",
        .accepted = "Accepted",
        .failed = "Failed",
    };
};
