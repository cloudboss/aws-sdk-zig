const aws = @import("aws");

const DynamicSsmParameterValue = @import("dynamic_ssm_parameter_value.zig").DynamicSsmParameterValue;
const SsmTargetAccount = @import("ssm_target_account.zig").SsmTargetAccount;

/// Details about the Systems Manager automation document that will be used as a
/// runbook
/// during an incident.
pub const SsmAutomation = struct {
    /// The automation document's name.
    document_name: []const u8,

    /// The automation document's version to use when running.
    document_version: ?[]const u8,

    /// The key-value pair to resolve dynamic parameter values when processing a
    /// Systems Manager Automation
    /// runbook.
    dynamic_parameters: ?[]const aws.map.MapEntry(DynamicSsmParameterValue),

    /// The key-value pair parameters to use when running the automation document.
    parameters: ?[]const aws.map.MapEntry([]const []const u8),

    /// The Amazon Resource Name (ARN) of the role that the automation document will
    /// assume when
    /// running commands.
    role_arn: []const u8,

    /// The account that the automation document will be run in. This can be in
    /// either the
    /// management account or an application account.
    target_account: ?SsmTargetAccount,

    pub const json_field_names = .{
        .document_name = "documentName",
        .document_version = "documentVersion",
        .dynamic_parameters = "dynamicParameters",
        .parameters = "parameters",
        .role_arn = "roleArn",
        .target_account = "targetAccount",
    };
};
