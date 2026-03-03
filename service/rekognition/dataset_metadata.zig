const DatasetType = @import("dataset_type.zig").DatasetType;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;
const DatasetStatusMessageCode = @import("dataset_status_message_code.zig").DatasetStatusMessageCode;

/// Summary information for an Amazon Rekognition Custom Labels dataset. For
/// more information, see
/// ProjectDescription.
pub const DatasetMetadata = struct {
    /// The Unix timestamp for the date and time that the dataset was created.
    creation_timestamp: ?i64 = null,

    /// The Amazon Resource Name (ARN) for the dataset.
    dataset_arn: ?[]const u8 = null,

    /// The type of the dataset.
    dataset_type: ?DatasetType = null,

    /// The status for the dataset.
    status: ?DatasetStatus = null,

    /// The status message for the dataset.
    status_message: ?[]const u8 = null,

    /// The status message code for the dataset operation. If a service error
    /// occurs, try the
    /// API call again later. If a client error occurs, check the input parameters
    /// to the dataset
    /// API call that failed.
    status_message_code: ?DatasetStatusMessageCode = null,

    pub const json_field_names = .{
        .creation_timestamp = "CreationTimestamp",
        .dataset_arn = "DatasetArn",
        .dataset_type = "DatasetType",
        .status = "Status",
        .status_message = "StatusMessage",
        .status_message_code = "StatusMessageCode",
    };
};
