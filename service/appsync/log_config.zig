const FieldLogLevel = @import("field_log_level.zig").FieldLogLevel;

/// The Amazon CloudWatch Logs configuration.
pub const LogConfig = struct {
    /// The service role that AppSync assumes to publish to CloudWatch
    /// logs in your account.
    cloud_watch_logs_role_arn: []const u8,

    /// Set to TRUE to exclude sections that contain information such as headers,
    /// context, and
    /// evaluated mapping templates, regardless of logging level.
    exclude_verbose_content: bool = false,

    /// The field logging level. Values can be NONE, ERROR, or ALL.
    ///
    /// * **NONE**: No field-level logs are
    /// captured.
    ///
    /// * **ERROR**: Logs the following information only for
    /// the fields that are in error:
    ///
    /// * The error section in the server response.
    ///
    /// * Field-level errors.
    ///
    /// * The generated request/response functions that got resolved for error
    /// fields.
    ///
    /// * **ALL**: The following information is logged for
    /// all fields in the query:
    ///
    /// * Field-level tracing information.
    ///
    /// * The generated request/response functions that got resolved for each
    /// field.
    field_log_level: FieldLogLevel,

    pub const json_field_names = .{
        .cloud_watch_logs_role_arn = "cloudWatchLogsRoleArn",
        .exclude_verbose_content = "excludeVerboseContent",
        .field_log_level = "fieldLogLevel",
    };
};
