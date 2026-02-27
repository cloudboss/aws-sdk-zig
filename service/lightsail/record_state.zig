pub const RecordState = enum {
    started,
    succeeded,
    failed,

    pub const json_field_names = .{
        .started = "Started",
        .succeeded = "Succeeded",
        .failed = "Failed",
    };
};
