pub const StopType = enum {
    complete,
    cancel,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .cancel = "CANCEL",
    };
};
