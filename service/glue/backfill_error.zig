const BackfillErrorCode = @import("backfill_error_code.zig").BackfillErrorCode;
const PartitionValueList = @import("partition_value_list.zig").PartitionValueList;

/// A list of errors that can occur when registering partition indexes for an
/// existing table.
///
/// These errors give the details about why an index registration failed and
/// provide a limited number of partitions in the response, so that you can fix
/// the partitions at fault and try registering the index again. The most common
/// set of errors that can occur are categorized as follows:
///
/// * EncryptedPartitionError: The partitions are encrypted.
///
/// * InvalidPartitionTypeDataError: The partition value doesn't match the data
///   type for that partition column.
///
/// * MissingPartitionValueError: The partitions are encrypted.
///
/// * UnsupportedPartitionCharacterError: Characters inside the partition value
///   are not supported. For example: U+0000 , U+0001, U+0002.
///
/// * InternalError: Any error which does not belong to other error codes.
pub const BackfillError = struct {
    /// The error code for an error that occurred when registering partition indexes
    /// for an existing table.
    code: ?BackfillErrorCode,

    /// A list of a limited number of partitions in the response.
    partitions: ?[]const PartitionValueList,

    pub const json_field_names = .{
        .code = "Code",
        .partitions = "Partitions",
    };
};
