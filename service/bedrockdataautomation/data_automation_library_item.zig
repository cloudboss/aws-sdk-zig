/// DataAutomationLibrary Item
pub const DataAutomationLibraryItem = struct {
    library_arn: []const u8,

    pub const json_field_names = .{
        .library_arn = "libraryArn",
    };
};
