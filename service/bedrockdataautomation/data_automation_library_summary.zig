/// Summary of a DataAutomationLibrary
pub const DataAutomationLibrarySummary = struct {
    creation_time: i64,

    library_arn: []const u8,

    library_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .library_arn = "libraryArn",
        .library_name = "libraryName",
    };
};
