pub const OperationStatus = enum {
    inprogress,
    success,
    @"error",

    pub const json_field_names = .{
        .inprogress = "INPROGRESS",
        .success = "SUCCESS",
        .@"error" = "ERROR",
    };
};
