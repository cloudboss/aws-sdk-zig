/// Contains Amazon S3 locations for storing specific types of AS2 message
/// files.
pub const CustomDirectoriesType = struct {
    /// Specifies a location to store failed AS2 message files.
    failed_files_directory: []const u8,

    /// Specifies a location to store MDN files.
    mdn_files_directory: []const u8,

    /// Specifies a location to store the payload for AS2 message files.
    payload_files_directory: []const u8,

    /// Specifies a location to store AS2 status messages.
    status_files_directory: []const u8,

    /// Specifies a location to store temporary AS2 message files.
    temporary_files_directory: []const u8,

    pub const json_field_names = .{
        .failed_files_directory = "FailedFilesDirectory",
        .mdn_files_directory = "MdnFilesDirectory",
        .payload_files_directory = "PayloadFilesDirectory",
        .status_files_directory = "StatusFilesDirectory",
        .temporary_files_directory = "TemporaryFilesDirectory",
    };
};
