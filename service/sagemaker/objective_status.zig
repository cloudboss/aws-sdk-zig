pub const ObjectiveStatus = enum {
    succeeded,
    pending,
    failed,

    pub const json_field_names = .{
        .succeeded = "Succeeded",
        .pending = "Pending",
        .failed = "Failed",
    };
};
