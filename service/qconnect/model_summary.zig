const CrossRegionStatus = @import("cross_region_status.zig").CrossRegionStatus;
const ModelLifecycle = @import("model_lifecycle.zig").ModelLifecycle;
const AIPromptType = @import("ai_prompt_type.zig").AIPromptType;

/// The summary of a model available to an Amazon Q in Connect assistant.
pub const ModelSummary = struct {
    /// The cross-region availability status of the model. `NONE` indicates the
    /// model is only available in a single region, `REGIONAL` indicates the model
    /// is available through regional inference, and `GLOBAL` indicates the model is
    /// available through global cross-region inference.
    cross_region_status: ?CrossRegionStatus = null,

    /// The display name of the model.
    display_name: []const u8,

    /// The timestamp when the model will reach end of life and no longer be
    /// available for use.
    end_of_life_timestamp: ?i64 = null,

    /// The timestamp when the model lifecycle will transition from `ACTIVE` to
    /// `LEGACY`.
    legacy_timestamp: ?i64 = null,

    /// The identifier of the model.
    model_id: []const u8,

    /// The current lifecycle of the model. `ACTIVE` indicates the model is
    /// recommended for use and `LEGACY` indicates the model is still usable but is
    /// deprecated.
    model_lifecycle: ?ModelLifecycle = null,

    /// The list of AI Prompt types that the model supports.
    supported_ai_prompt_types: ?[]const AIPromptType = null,

    /// Whether the model supports prompt caching.
    supports_prompt_caching: ?bool = null,

    pub const json_field_names = .{
        .cross_region_status = "crossRegionStatus",
        .display_name = "displayName",
        .end_of_life_timestamp = "endOfLifeTimestamp",
        .legacy_timestamp = "legacyTimestamp",
        .model_id = "modelId",
        .model_lifecycle = "modelLifecycle",
        .supported_ai_prompt_types = "supportedAIPromptTypes",
        .supports_prompt_caching = "supportsPromptCaching",
    };
};
