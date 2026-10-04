/// An object that contains the details of a service job that couldn't be
/// terminated by a `TerminateServiceJobs` operation.
pub const TerminateServiceJobsErrorDetail = struct {
    /// An error code that identifies the reason the service job couldn't be
    /// terminated. Valid values are:
    ///
    /// * `ValidationException` – A service job identifier in the request is
    ///   malformed or isn't valid.
    ///
    /// * `ClientException` – The request failed because of a client error.
    ///
    /// * `ThrottlingException` – The request was throttled. Retry the request.
    ///
    /// * `ServerException` – An internal error occurred. Retry the request.
    ///
    /// * `AccessDenied` – The caller isn't authorized to perform the action on the
    ///   specified service job.
    code: []const u8,

    /// The service job ID of the service job that couldn't be terminated.
    job: []const u8,

    /// A message that describes the reason the service job couldn't be terminated.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .job = "job",
        .message = "message",
    };
};
