/// Information about a named query ID that could not be processed.
pub const UnprocessedNamedQueryId = struct {
    /// The error code returned when the processing request for the named query
    /// failed, if
    /// applicable.
    error_code: ?[]const u8 = null,

    /// The error message returned when the processing request for the named query
    /// failed, if
    /// applicable.
    error_message: ?[]const u8 = null,

    /// The unique identifier of the named query.
    named_query_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .named_query_id = "NamedQueryId",
    };
};
