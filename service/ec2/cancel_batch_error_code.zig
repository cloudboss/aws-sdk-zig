pub const CancelBatchErrorCode = enum {
    fleet_request_id_does_not_exist,
    fleet_request_id_malformed,
    fleet_request_not_in_cancellable_state,
    unexpected_error,
};
