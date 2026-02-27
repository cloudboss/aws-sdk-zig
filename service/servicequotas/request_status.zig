pub const RequestStatus = enum {
    pending,
    case_opened,
    approved,
    denied,
    case_closed,
    not_approved,
    invalid_request,

    pub const json_field_names = .{
        .pending = "PENDING",
        .case_opened = "CASE_OPENED",
        .approved = "APPROVED",
        .denied = "DENIED",
        .case_closed = "CASE_CLOSED",
        .not_approved = "NOT_APPROVED",
        .invalid_request = "INVALID_REQUEST",
    };
};
