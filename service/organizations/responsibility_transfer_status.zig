pub const ResponsibilityTransferStatus = enum {
    requested,
    declined,
    canceled,
    expired,
    accepted,
    withdrawn,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .declined = "DECLINED",
        .canceled = "CANCELED",
        .expired = "EXPIRED",
        .accepted = "ACCEPTED",
        .withdrawn = "WITHDRAWN",
    };
};
