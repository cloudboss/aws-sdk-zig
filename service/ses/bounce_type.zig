pub const BounceType = enum {
    does_not_exist,
    message_too_large,
    exceeded_quota,
    content_rejected,
    @"undefined",
    temporary_failure,
};
