pub const StatefulAction = enum {
    pass,
    drop,
    alert,
    reject,

    pub const json_field_names = .{
        .pass = "PASS",
        .drop = "DROP",
        .alert = "ALERT",
        .reject = "REJECT",
    };
};
