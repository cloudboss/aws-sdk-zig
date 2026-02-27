pub const NodeUpdateStatus = enum {
    not_applied,
    waiting_to_start,
    in_progress,
    stopping,
    stopped,
    complete,
};
