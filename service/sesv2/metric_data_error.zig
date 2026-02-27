const QueryErrorCode = @import("query_error_code.zig").QueryErrorCode;

/// An error corresponding to the unsuccessful processing of a single metric
/// data query.
pub const MetricDataError = struct {
    /// The query error code. Can be one of:
    ///
    /// * `INTERNAL_FAILURE` – Amazon SES has failed to process one of the queries.
    ///
    /// * `ACCESS_DENIED` – You have insufficient access to retrieve metrics
    /// based on the given query.
    code: ?QueryErrorCode,

    /// The query identifier.
    id: ?[]const u8,

    /// The error message associated with the current query error.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .id = "Id",
        .message = "Message",
    };
};
