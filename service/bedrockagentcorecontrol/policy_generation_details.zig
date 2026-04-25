/// Represents the information identifying a generated policy asset from the
/// AI-powered policy generation process within the AgentCore Policy system.
/// Each asset contains a Cedar policy statement generated from natural language
/// input, along with associated metadata and analysis findings to help users
/// evaluate and select the most appropriate policy option.
pub const PolicyGenerationDetails = struct {
    /// The unique identifier for this generated policy asset within the policy
    /// generation request.
    policy_generation_asset_id: []const u8,

    /// The unique identifier for this policy generation request.
    policy_generation_id: []const u8,

    pub const json_field_names = .{
        .policy_generation_asset_id = "policyGenerationAssetId",
        .policy_generation_id = "policyGenerationId",
    };
};
