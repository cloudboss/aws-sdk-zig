const LastRunErrorStatusCode = @import("last_run_error_status_code.zig").LastRunErrorStatusCode;

/// Specifies whether any account- or bucket-level access errors occurred when a
/// classification job ran. For information about using logging data to
/// investigate these errors, see [Monitoring sensitive data discovery
/// jobs](https://docs.aws.amazon.com/macie/latest/user/discovery-jobs-monitor-cw-logs.html) in the *Amazon Macie User Guide*.
pub const LastRunErrorStatus = struct {
    /// Specifies whether any account- or bucket-level access errors occurred when
    /// the job ran. For a recurring job, this value indicates the error status of
    /// the job's most recent run. Possible values are:
    ///
    /// * ERROR - One or more errors occurred. Amazon Macie didn't process all the
    ///   data specified for the job.
    /// * NONE - No errors occurred. Macie processed all the data specified for the
    ///   job.
    code: ?LastRunErrorStatusCode,

    pub const json_field_names = .{
        .code = "code",
    };
};
