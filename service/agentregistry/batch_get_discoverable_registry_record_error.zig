const BatchGetDiscoverableRegistryRecordErrorCode = @import("batch_get_discoverable_registry_record_error_code.zig").BatchGetDiscoverableRegistryRecordErrorCode;

/// Describes why a requested record could not be retrieved.
pub const BatchGetDiscoverableRegistryRecordError = struct {
    /// The machine-readable reason that the record could not be retrieved.
    error_code: BatchGetDiscoverableRegistryRecordErrorCode,

    /// An optional human-readable detail about the error. Do not parse this value
    /// programmatically.
    message: ?[]const u8 = null,

    /// The identifier of the record that could not be retrieved, echoed from the
    /// request in the same format that you supplied (ARN or record ID).
    record_id: []const u8,

    /// The identifier of the registry the record was requested from, echoed from
    /// the request.
    registry_id: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .message = "message",
        .record_id = "recordId",
        .registry_id = "registryId",
    };
};
