/// The status of a request to retrieve occurrences of sensitive data reported
/// by a finding. Possible values are:
pub const RevealRequestStatus = enum {
    success,
    processing,
    @"error",

    pub const json_field_names = .{
        .success = "SUCCESS",
        .processing = "PROCESSING",
        .@"error" = "ERROR",
    };
};
