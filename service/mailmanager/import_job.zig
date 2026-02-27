const ImportDataFormat = @import("import_data_format.zig").ImportDataFormat;
const ImportJobStatus = @import("import_job_status.zig").ImportJobStatus;

/// Details about an import job.
pub const ImportJob = struct {
    /// The unique identifier of the address list the import job was created for.
    address_list_id: []const u8,

    /// The timestamp of when the import job was completed.
    completed_timestamp: ?i64,

    /// The timestamp of when the import job was created.
    created_timestamp: i64,

    /// The reason for failure of an import job.
    @"error": ?[]const u8,

    /// The number of addresses in the input that failed to get imported into
    /// address list.
    failed_items_count: ?i32,

    /// The format of the input for the import job.
    import_data_format: ImportDataFormat,

    /// The number of addresses in the input that were successfully imported into
    /// the address list.
    imported_items_count: ?i32,

    /// The identifier of the import job.
    job_id: []const u8,

    /// A user-friendly name for the import job.
    name: []const u8,

    /// The pre-signed URL target for uploading the input file.
    pre_signed_url: []const u8,

    /// The timestamp of when the import job was started.
    start_timestamp: ?i64,

    /// The status of the import job.
    status: ImportJobStatus,

    pub const json_field_names = .{
        .address_list_id = "AddressListId",
        .completed_timestamp = "CompletedTimestamp",
        .created_timestamp = "CreatedTimestamp",
        .@"error" = "Error",
        .failed_items_count = "FailedItemsCount",
        .import_data_format = "ImportDataFormat",
        .imported_items_count = "ImportedItemsCount",
        .job_id = "JobId",
        .name = "Name",
        .pre_signed_url = "PreSignedUrl",
        .start_timestamp = "StartTimestamp",
        .status = "Status",
    };
};
