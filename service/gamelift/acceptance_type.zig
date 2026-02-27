pub const AcceptanceType = enum {
    accept,
    reject,

    pub const json_field_names = .{
        .accept = "ACCEPT",
        .reject = "REJECT",
    };
};
