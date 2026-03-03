/// The response object for this operation.
pub const BackendJobRespObj = struct {
    /// The app ID.
    app_id: []const u8,

    /// The name of the backend environment.
    backend_environment_name: []const u8,

    /// The time when the job was created.
    create_time: ?[]const u8 = null,

    /// If the request fails, this error is returned.
    @"error": ?[]const u8 = null,

    /// The ID for the job.
    job_id: ?[]const u8 = null,

    /// The name of the operation.
    operation: ?[]const u8 = null,

    /// The current status of the request.
    status: ?[]const u8 = null,

    /// The time when the job was last updated.
    update_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "AppId",
        .backend_environment_name = "BackendEnvironmentName",
        .create_time = "CreateTime",
        .@"error" = "Error",
        .job_id = "JobId",
        .operation = "Operation",
        .status = "Status",
        .update_time = "UpdateTime",
    };
};
