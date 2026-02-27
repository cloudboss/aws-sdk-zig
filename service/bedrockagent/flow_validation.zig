const FlowValidationDetails = @import("flow_validation_details.zig").FlowValidationDetails;
const FlowValidationSeverity = @import("flow_validation_severity.zig").FlowValidationSeverity;
const FlowValidationType = @import("flow_validation_type.zig").FlowValidationType;

/// Contains information about validation of the flow.
///
/// This data type is used in the following API operations:
///
/// * [GetFlow
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_GetFlow.html#API_agent_GetFlow_ResponseSyntax)
/// * [GetFlowVersion
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_GetFlowVersion.html#API_agent_GetFlowVersion_ResponseSyntax)
pub const FlowValidation = struct {
    /// Specific details about the validation issue encountered in the flow.
    details: ?FlowValidationDetails,

    /// A message describing the validation error.
    message: []const u8,

    /// The severity of the issue described in the message.
    severity: FlowValidationSeverity,

    /// The type of validation issue encountered in the flow.
    @"type": ?FlowValidationType,

    pub const json_field_names = .{
        .details = "details",
        .message = "message",
        .severity = "severity",
        .@"type" = "type",
    };
};
