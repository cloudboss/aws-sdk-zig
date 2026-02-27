const GuardrailCrossRegionDetails = @import("guardrail_cross_region_details.zig").GuardrailCrossRegionDetails;
const GuardrailStatus = @import("guardrail_status.zig").GuardrailStatus;

/// Contains details about a guardrail.
///
/// This data type is used in the following API operations:
///
/// * [ListGuardrails response
///   body](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListGuardrails.html#API_ListGuardrails_ResponseSyntax)
pub const GuardrailSummary = struct {
    /// The ARN of the guardrail.
    arn: []const u8,

    /// The date and time at which the guardrail was created.
    created_at: i64,

    /// Details about the system-defined guardrail profile that you're using with
    /// your guardrail, including the guardrail profile ID and Amazon Resource Name
    /// (ARN).
    cross_region_details: ?GuardrailCrossRegionDetails,

    /// A description of the guardrail.
    description: ?[]const u8,

    /// The unique identifier of the guardrail.
    id: []const u8,

    /// The name of the guardrail.
    name: []const u8,

    /// The status of the guardrail.
    status: GuardrailStatus,

    /// The date and time at which the guardrail was last updated.
    updated_at: i64,

    /// The version of the guardrail.
    version: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .cross_region_details = "crossRegionDetails",
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
