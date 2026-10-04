const aws = @import("aws");

const SessionConfigurationOverrides = @import("session_configuration_overrides.zig").SessionConfigurationOverrides;

pub const StartSessionRequest = struct {
    /// The ID of the application on which to start the session.
    application_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client token, the server returns the successful
    /// response without performing the operation again.
    client_token: []const u8,

    /// The configuration overrides for the session. Only runtime configuration
    /// overrides are supported.
    configuration_overrides: ?SessionConfigurationOverrides = null,

    /// The execution role ARN for the session. Amazon EMR Serverless uses this role
    /// to access Amazon Web Services resources on your behalf during session
    /// execution.
    execution_role_arn: []const u8,

    /// The idle timeout in minutes for the session. After the session remains idle
    /// for this duration, Amazon EMR Serverless automatically terminates it.
    idle_timeout_minutes: ?i64 = null,

    /// The optional name for the session.
    name: ?[]const u8 = null,

    /// The tags to assign to the session.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .client_token = "clientToken",
        .configuration_overrides = "configurationOverrides",
        .execution_role_arn = "executionRoleArn",
        .idle_timeout_minutes = "idleTimeoutMinutes",
        .name = "name",
        .tags = "tags",
    };
};
