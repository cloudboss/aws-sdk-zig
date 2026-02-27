/// Queues can be ACTIVE or PAUSED. If you pause a queue, jobs in that queue
/// won't begin. Jobs that are running when you pause a queue continue to run
/// until they finish or result in an error.
pub const QueueStatus = enum {
    active,
    paused,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .paused = "PAUSED",
    };
};
