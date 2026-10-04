const RemediationGuidanceContext = @import("remediation_guidance_context.zig").RemediationGuidanceContext;
const RemediationGuidanceExamples = @import("remediation_guidance_examples.zig").RemediationGuidanceExamples;
const RemediationGuidanceMetadata = @import("remediation_guidance_metadata.zig").RemediationGuidanceMetadata;
const RemediationGuidanceSpecification = @import("remediation_guidance_specification.zig").RemediationGuidanceSpecification;

/// A remediation guidebook outlining guidance in resolving the remediation
/// target.
pub const RemediationGuidance = struct {
    /// The context behind the remediation target's existence and guidance.
    context: RemediationGuidanceContext,

    /// Provided remediation guidance examples in different formats that can be run
    /// for remediating the target.
    examples: RemediationGuidanceExamples,

    /// The metadata of the remediation guidance.
    metadata: RemediationGuidanceMetadata,

    /// The remediation pattern of the remediation target.
    pattern: []const u8,

    /// The specification of the remediation target guidance. This outlines required
    /// resource parameters
    /// and permissions, remediation steps, and the end state.
    specification: RemediationGuidanceSpecification,

    /// The name of the remediation target type.
    target_type_name: []const u8,

    /// The guidance version.
    version: []const u8,

    pub const json_field_names = .{
        .context = "Context",
        .examples = "Examples",
        .metadata = "Metadata",
        .pattern = "Pattern",
        .specification = "Specification",
        .target_type_name = "TargetTypeName",
        .version = "Version",
    };
};
