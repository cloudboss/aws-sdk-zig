const ImportStatus = @import("import_status.zig").ImportStatus;

pub const ListImportsRequest = struct {
    /// The ARN of the destination event data store.
    destination: ?[]const u8 = null,

    /// The status of the import.
    import_status: ?ImportStatus = null,

    /// The maximum number of imports to display on a single page.
    max_results: ?i32 = null,

    /// A token you can use to get the next page of import results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .import_status = "ImportStatus",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
