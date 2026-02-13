pub const LastResourceDataSyncStatus = enum {
    successful,
    failed,
    inprogress,

    pub const json_field_names = .{
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
        .inprogress = "INPROGRESS",
    };
};
