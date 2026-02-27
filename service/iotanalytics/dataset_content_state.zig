pub const DatasetContentState = enum {
    creating,
    succeeded,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
