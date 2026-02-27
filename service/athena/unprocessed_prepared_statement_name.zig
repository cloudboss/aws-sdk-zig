/// The name of a prepared statement that could not be returned.
pub const UnprocessedPreparedStatementName = struct {
    /// The error code returned when the request for the prepared statement failed.
    error_code: ?[]const u8,

    /// The error message containing the reason why the prepared statement could not
    /// be
    /// returned. The following error messages are possible:
    ///
    /// * `INVALID_INPUT` - The name of the prepared statement that was
    /// provided is not valid (for example, the name is too long).
    ///
    /// * `STATEMENT_NOT_FOUND` - A prepared statement with the name provided
    /// could not be found.
    ///
    /// * `UNAUTHORIZED` - The requester does not have permission to access
    /// the workgroup that contains the prepared statement.
    error_message: ?[]const u8,

    /// The name of a prepared statement that could not be returned due to an error.
    statement_name: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .statement_name = "StatementName",
    };
};
