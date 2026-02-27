/// The list of the findings that cannot be imported. For each finding, the list
/// provides
/// the error.
pub const ImportFindingsError = struct {
    /// The code of the error returned by the `BatchImportFindings` operation.
    error_code: []const u8,

    /// The message of the error returned by the `BatchImportFindings`
    /// operation.
    error_message: []const u8,

    /// The identifier of the finding that could not be updated.
    id: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .id = "Id",
    };
};
