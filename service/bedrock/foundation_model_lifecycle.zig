const FoundationModelLifecycleStatus = @import("foundation_model_lifecycle_status.zig").FoundationModelLifecycleStatus;

/// Details about whether a model version is available or deprecated.
pub const FoundationModelLifecycle = struct {
    /// Specifies whether a model version is available (`ACTIVE`) or deprecated
    /// (`LEGACY`.
    status: FoundationModelLifecycleStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};
