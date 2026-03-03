const aws = @import("aws");

const ExecutionControls = @import("execution_controls.zig").ExecutionControls;
const RemediationParameterValue = @import("remediation_parameter_value.zig").RemediationParameterValue;
const RemediationTargetType = @import("remediation_target_type.zig").RemediationTargetType;

/// An object that represents the details about the remediation configuration
/// that includes the remediation action, parameters, and data to execute the
/// action.
pub const RemediationConfiguration = struct {
    /// Amazon Resource Name (ARN) of remediation configuration.
    arn: ?[]const u8 = null,

    /// The remediation is triggered automatically.
    automatic: bool = false,

    /// The name of the Config rule.
    config_rule_name: []const u8,

    /// Name of the service that owns the service-linked rule, if applicable.
    created_by_service: ?[]const u8 = null,

    /// An ExecutionControls object.
    execution_controls: ?ExecutionControls = null,

    /// The maximum number of failed attempts for auto-remediation. If you do not
    /// select a number, the default is 5.
    ///
    /// For example, if you specify MaximumAutomaticAttempts as 5 with
    /// RetryAttemptSeconds as 50 seconds,
    ///
    /// Config will put a RemediationException on your behalf for the failing
    /// resource after the 5th failed attempt within 50 seconds.
    maximum_automatic_attempts: ?i32 = null,

    /// An object of the RemediationParameterValue.
    parameters: ?[]const aws.map.MapEntry(RemediationParameterValue) = null,

    /// The type of a resource.
    resource_type: ?[]const u8 = null,

    /// Time window to determine whether or not to add a remediation exception to
    /// prevent infinite remediation attempts.
    /// If `MaximumAutomaticAttempts` remediation attempts have been made under
    /// `RetryAttemptSeconds`, a remediation exception will be added to the
    /// resource.
    /// If you do not select a number, the default is 60 seconds.
    ///
    /// For example, if you specify `RetryAttemptSeconds` as 50 seconds and
    /// `MaximumAutomaticAttempts` as 5,
    /// Config will run auto-remediations 5 times within 50 seconds before adding a
    /// remediation exception to the resource.
    retry_attempt_seconds: ?i64 = null,

    /// Target ID is the name of the SSM document.
    target_id: []const u8,

    /// The type of the target. Target executes remediation. For example, SSM
    /// document.
    target_type: RemediationTargetType,

    /// Version of the target. For example, version of the SSM document.
    ///
    /// If you make backward incompatible changes to the SSM document,
    /// you must call PutRemediationConfiguration API again to ensure the
    /// remediations can run.
    target_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .automatic = "Automatic",
        .config_rule_name = "ConfigRuleName",
        .created_by_service = "CreatedByService",
        .execution_controls = "ExecutionControls",
        .maximum_automatic_attempts = "MaximumAutomaticAttempts",
        .parameters = "Parameters",
        .resource_type = "ResourceType",
        .retry_attempt_seconds = "RetryAttemptSeconds",
        .target_id = "TargetId",
        .target_type = "TargetType",
        .target_version = "TargetVersion",
    };
};
