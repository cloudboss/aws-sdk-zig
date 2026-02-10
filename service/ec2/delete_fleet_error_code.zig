pub const DeleteFleetErrorCode = enum {
    fleet_id_does_not_exist,
    fleet_id_malformed,
    fleet_not_in_deletable_state,
    unexpected_error,
};
