pub const StopStatus = enum {
    pending,
    succeeded,

    pub const json_field_names = .{
        .pending = "PENDING",
        .succeeded = "SUCCEEDED",
    };
};
