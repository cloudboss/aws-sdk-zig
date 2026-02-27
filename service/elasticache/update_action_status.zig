pub const UpdateActionStatus = enum {
    not_applied,
    waiting_to_start,
    in_progress,
    stopping,
    stopped,
    complete,
    scheduling,
    scheduled,
    not_applicable,
};
