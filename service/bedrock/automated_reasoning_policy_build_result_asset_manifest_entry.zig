const AutomatedReasoningPolicyBuildResultAssetType = @import("automated_reasoning_policy_build_result_asset_type.zig").AutomatedReasoningPolicyBuildResultAssetType;

/// Represents a single entry in the asset manifest, describing one artifact
/// produced by the build workflow.
pub const AutomatedReasoningPolicyBuildResultAssetManifestEntry = struct {
    /// A unique identifier for the asset, if applicable. Use this ID when
    /// requesting specific assets through the API.
    asset_id: ?[]const u8 = null,

    /// A human-readable name for the asset, if applicable. This helps identify
    /// specific documents or reports within the workflow results.
    asset_name: ?[]const u8 = null,

    /// The type of asset (e.g., BUILD_LOG, QUALITY_REPORT, POLICY_DEFINITION,
    /// GENERATED_TEST_CASES, POLICY_SCENARIOS, FIDELITY_REPORT, ASSET_MANIFEST,
    /// SOURCE_DOCUMENT).
    asset_type: AutomatedReasoningPolicyBuildResultAssetType,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .asset_name = "assetName",
        .asset_type = "assetType",
    };
};
