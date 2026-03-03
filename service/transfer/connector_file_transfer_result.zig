const TransferTableStatus = @import("transfer_table_status.zig").TransferTableStatus;

/// A structure that contains the details for files transferred using an SFTP
/// connector, during a single transfer.
pub const ConnectorFileTransferResult = struct {
    /// For transfers that fail, this parameter contains a code indicating the
    /// reason. For example, `RETRIEVE_FILE_NOT_FOUND`
    failure_code: ?[]const u8 = null,

    /// For transfers that fail, this parameter describes the reason for the
    /// failure.
    failure_message: ?[]const u8 = null,

    /// The filename and path to where the file was sent to or retrieved from.
    file_path: []const u8,

    /// The current status for the transfer.
    status_code: TransferTableStatus,

    pub const json_field_names = .{
        .failure_code = "FailureCode",
        .failure_message = "FailureMessage",
        .file_path = "FilePath",
        .status_code = "StatusCode",
    };
};
