const ModelLifecycle = @import("model_lifecycle.zig").ModelLifecycle;

/// Summary information about an available AI model.
pub const ModelSummary = struct {
    /// The minimum client compatibility version required to use this model.
    minimum_compatibility_version: i32,

    /// The unique identifier of the model.
    model_id: []const u8,

    /// The lifecycle information for the model.
    model_lifecycle: ModelLifecycle,

    pub const json_field_names = .{
        .minimum_compatibility_version = "minimumCompatibilityVersion",
        .model_id = "modelId",
        .model_lifecycle = "modelLifecycle",
    };
};
