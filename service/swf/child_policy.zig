pub const ChildPolicy = enum {
    terminate,
    request_cancel,
    abandon,

    pub const json_field_names = .{
        .terminate = "TERMINATE",
        .request_cancel = "REQUEST_CANCEL",
        .abandon = "ABANDON",
    };
};
