/// An array of structures, where each structure includes an error indicating
/// that one of the requests in the array was not valid.
pub const BatchUpdateExclusionWindowsError = struct {
    /// The error code.
    error_code: []const u8,

    /// The error message.
    error_message: []const u8,

    /// The SLO ID in the error.
    slo_id: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .slo_id = "SloId",
    };
};
