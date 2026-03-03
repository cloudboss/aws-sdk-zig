const aws = @import("aws");

const ActionCategory = @import("action_category.zig").ActionCategory;
const SsmExternalParameter = @import("ssm_external_parameter.zig").SsmExternalParameter;
const SsmParameterStoreParameter = @import("ssm_parameter_store_parameter.zig").SsmParameterStoreParameter;

pub const SourceServerActionDocument = struct {
    /// Source server post migration custom action ID.
    action_id: ?[]const u8 = null,

    /// Source server post migration custom action name.
    action_name: ?[]const u8 = null,

    /// Source server post migration custom action active status.
    active: ?bool = null,

    /// Source server post migration custom action category.
    category: ?ActionCategory = null,

    /// Source server post migration custom action description.
    description: ?[]const u8 = null,

    /// Source server post migration custom action document identifier.
    document_identifier: ?[]const u8 = null,

    /// Source server post migration custom action document version.
    document_version: ?[]const u8 = null,

    /// Source server post migration custom action external parameters.
    external_parameters: ?[]const aws.map.MapEntry(SsmExternalParameter) = null,

    /// Source server post migration custom action must succeed for cutover.
    must_succeed_for_cutover: ?bool = null,

    /// Source server post migration custom action order.
    order: ?i32 = null,

    /// Source server post migration custom action parameters.
    parameters: ?[]const aws.map.MapEntry([]const SsmParameterStoreParameter) = null,

    /// Source server post migration custom action timeout in seconds.
    timeout_seconds: ?i32 = null,

    pub const json_field_names = .{
        .action_id = "actionID",
        .action_name = "actionName",
        .active = "active",
        .category = "category",
        .description = "description",
        .document_identifier = "documentIdentifier",
        .document_version = "documentVersion",
        .external_parameters = "externalParameters",
        .must_succeed_for_cutover = "mustSucceedForCutover",
        .order = "order",
        .parameters = "parameters",
        .timeout_seconds = "timeoutSeconds",
    };
};
