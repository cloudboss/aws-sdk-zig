pub const ReplicationStatusType = enum {
    replicating,
    completed,

    pub const json_field_names = .{
        .replicating = "REPLICATING",
        .completed = "COMPLETED",
    };
};
