pub const ResponderErrorMaskingAction = enum {
    no_bid,
    passthrough,

    pub const json_field_names = .{
        .no_bid = "NO_BID",
        .passthrough = "PASSTHROUGH",
    };
};
