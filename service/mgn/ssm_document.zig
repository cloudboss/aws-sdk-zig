const aws = @import("aws");

const SsmExternalParameter = @import("ssm_external_parameter.zig").SsmExternalParameter;
const SsmParameterStoreParameter = @import("ssm_parameter_store_parameter.zig").SsmParameterStoreParameter;

/// AWS Systems Manager Document.
pub const SsmDocument = struct {
    /// User-friendly name for the AWS Systems Manager Document.
    action_name: []const u8,

    /// AWS Systems Manager Document external parameters.
    external_parameters: ?[]const aws.map.MapEntry(SsmExternalParameter),

    /// If true, Cutover will not be enabled if the document has failed.
    must_succeed_for_cutover: ?bool,

    /// AWS Systems Manager Document parameters.
    parameters: ?[]const aws.map.MapEntry([]const SsmParameterStoreParameter),

    /// AWS Systems Manager Document name or full ARN.
    ssm_document_name: []const u8,

    /// AWS Systems Manager Document timeout seconds.
    timeout_seconds: ?i32,

    pub const json_field_names = .{
        .action_name = "actionName",
        .external_parameters = "externalParameters",
        .must_succeed_for_cutover = "mustSucceedForCutover",
        .parameters = "parameters",
        .ssm_document_name = "ssmDocumentName",
        .timeout_seconds = "timeoutSeconds",
    };
};
