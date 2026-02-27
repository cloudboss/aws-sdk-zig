pub const TrainingMode = enum {
    full,
    update,
    autotrain,

    pub const json_field_names = .{
        .full = "FULL",
        .update = "UPDATE",
        .autotrain = "AUTOTRAIN",
    };
};
