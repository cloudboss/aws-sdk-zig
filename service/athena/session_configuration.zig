const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

/// Contains session configuration information.
pub const SessionConfiguration = struct {
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The ARN of the execution role used to access user resources for Spark
    /// sessions and
    /// Identity Center enabled workgroups. This property applies only to Spark
    /// enabled
    /// workgroups and Identity Center enabled workgroups.
    execution_role: ?[]const u8 = null,

    /// The idle timeout in seconds for the session.
    idle_timeout_seconds: ?i64 = null,

    /// The idle timeout in seconds for the session.
    session_idle_timeout_in_minutes: ?i32 = null,

    /// The Amazon S3 location that stores information for the notebook.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_configuration = "EncryptionConfiguration",
        .execution_role = "ExecutionRole",
        .idle_timeout_seconds = "IdleTimeoutSeconds",
        .session_idle_timeout_in_minutes = "SessionIdleTimeoutInMinutes",
        .working_directory = "WorkingDirectory",
    };
};
