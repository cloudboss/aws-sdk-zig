pub const SnapshotRequestedBy = enum {
    user,
    firehose,

    pub const json_field_names = .{
        .user = "USER",
        .firehose = "FIREHOSE",
    };
};
