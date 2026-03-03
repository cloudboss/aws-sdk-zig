/// This array is empty if the API operation was successful for all the rules
/// specified in
/// the request. If the operation could not process one of the rules, the
/// following data is
/// returned for each of those rules.
pub const PartialFailure = struct {
    /// The type of error.
    exception_type: ?[]const u8 = null,

    /// The code of the error.
    failure_code: ?[]const u8 = null,

    /// A description of the error.
    failure_description: ?[]const u8 = null,

    /// The specified rule that could not be deleted.
    failure_resource: ?[]const u8 = null,

    pub const json_field_names = .{
        .exception_type = "ExceptionType",
        .failure_code = "FailureCode",
        .failure_description = "FailureDescription",
        .failure_resource = "FailureResource",
    };
};
