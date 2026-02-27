pub const PrimaryEmailUpdateStatus = enum {
    pending,
    accepted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .accepted = "ACCEPTED",
    };
};
