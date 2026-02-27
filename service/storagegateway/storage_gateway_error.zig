const aws = @import("aws");

const ErrorCode = @import("error_code.zig").ErrorCode;

/// Provides additional information about an error that was returned by the
/// service. See the
/// `errorCode` and `errorDetails` members for more information about
/// the error.
pub const StorageGatewayError = struct {
    /// Additional information about the error.
    error_code: ?ErrorCode,

    /// Human-readable text that provides detail about the error that occurred.
    error_details: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_details = "errorDetails",
    };
};
