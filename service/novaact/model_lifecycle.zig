const ModelStatus = @import("model_status.zig").ModelStatus;

/// Lifecycle information for an AI model.
pub const ModelLifecycle = struct {
    /// The current lifecycle status of the model.
    status: ModelStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};
