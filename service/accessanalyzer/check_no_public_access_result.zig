pub const CheckNoPublicAccessResult = enum {
    pass,
    fail,

    pub const json_field_names = .{
        .pass = "PASS",
        .fail = "FAIL",
    };
};
