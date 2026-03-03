const PolicyDefinition = @import("policy_definition.zig").PolicyDefinition;
const Finding = @import("finding.zig").Finding;

/// Represents a generated policy asset from the AI-powered policy generation
/// process within the AgentCore Policy system. Each asset contains a Cedar
/// policy statement generated from natural language input, along with
/// associated metadata and analysis findings to help users evaluate and select
/// the most appropriate policy option.
pub const PolicyGenerationAsset = struct {
    definition: ?PolicyDefinition = null,

    /// Analysis findings and insights related to this specific generated policy
    /// asset. These findings may include validation results, potential issues, or
    /// recommendations for improvement to help users evaluate the quality and
    /// appropriateness of the generated policy.
    findings: []const Finding,

    /// The unique identifier for this generated policy asset within the policy
    /// generation request. This ID can be used to reference specific generated
    /// policy options when creating actual policies from the generation results.
    policy_generation_asset_id: []const u8,

    /// The portion of the original natural language input that this generated
    /// policy asset addresses. This helps users understand which part of their
    /// policy description was translated into this specific Cedar policy statement,
    /// enabling better policy selection and refinement. When a single natural
    /// language input describes multiple authorization requirements, the generation
    /// process creates separate policy assets for each requirement, with each
    /// asset's rawTextFragment showing which requirement it addresses. Use this
    /// mapping to verify that all parts of your natural language input were
    /// correctly translated into Cedar policies.
    raw_text_fragment: []const u8,

    pub const json_field_names = .{
        .definition = "definition",
        .findings = "findings",
        .policy_generation_asset_id = "policyGenerationAssetId",
        .raw_text_fragment = "rawTextFragment",
    };
};
