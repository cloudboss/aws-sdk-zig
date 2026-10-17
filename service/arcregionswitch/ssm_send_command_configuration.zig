const aws = @import("aws");

const SsmDocumentConfig = @import("ssm_document_config.zig").SsmDocumentConfig;
const SsmSendCommandUngraceful = @import("ssm_send_command_ungraceful.zig").SsmSendCommandUngraceful;

/// Configuration for an AWS Systems Manager `SendCommand` execution block in a
/// Region switch plan. This execution block runs a Systems Manager document on
/// the managed nodes that you target in each Amazon Web Services Region of the
/// plan.
pub const SsmSendCommandConfiguration = struct {
    /// The Systems Manager document and target configuration for each Amazon Web
    /// Services Region in the plan. Provide an entry for each Amazon Web Services
    /// Region that you want the command to run in.
    region_documents: []const aws.map.MapEntry(SsmDocumentConfig),

    /// How often, in minutes, Region switch retries the command if it returns a
    /// failure.
    retry_interval_minutes: f32,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// Specifies the settings that determine how the execution block behaves when
    /// the plan runs ungracefully, such as whether to skip the command.
    ungraceful: ?SsmSendCommandUngraceful = null,

    pub const json_field_names = .{
        .region_documents = "regionDocuments",
        .retry_interval_minutes = "retryIntervalMinutes",
        .timeout_minutes = "timeoutMinutes",
        .ungraceful = "ungraceful",
    };
};
