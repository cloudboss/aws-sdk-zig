const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const BatchPermissionsRequestEntry = @import("batch_permissions_request_entry.zig").BatchPermissionsRequestEntry;

/// A list of failures when performing a batch grant or batch revoke operation.
pub const BatchPermissionsFailureEntry = struct {
    /// An error message that applies to the failure of the entry.
    @"error": ?ErrorDetail = null,

    /// An identifier for an entry of the batch request.
    request_entry: ?BatchPermissionsRequestEntry = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .request_entry = "RequestEntry",
    };
};
