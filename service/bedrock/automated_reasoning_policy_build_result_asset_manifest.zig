const AutomatedReasoningPolicyBuildResultAssetManifestEntry = @import("automated_reasoning_policy_build_result_asset_manifest_entry.zig").AutomatedReasoningPolicyBuildResultAssetManifestEntry;

/// A catalog of all artifacts produced by a build workflow, providing a
/// comprehensive list of available assets including their types and
/// identifiers.
pub const AutomatedReasoningPolicyBuildResultAssetManifest = struct {
    /// The list of asset entries in the manifest, each describing an available
    /// artifact that can be retrieved.
    entries: []const AutomatedReasoningPolicyBuildResultAssetManifestEntry,

    pub const json_field_names = .{
        .entries = "entries",
    };
};
