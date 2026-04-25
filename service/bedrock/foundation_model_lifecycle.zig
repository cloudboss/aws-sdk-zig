const FoundationModelLifecycleStatus = @import("foundation_model_lifecycle_status.zig").FoundationModelLifecycleStatus;

/// Details about whether a model version is available or deprecated.
pub const FoundationModelLifecycle = struct {
    /// Time when the model is no longer available for use
    end_of_life_time: ?i64 = null,

    /// Time when the model enters legacy state. Models in legacy state can still be
    /// used, but users should plan to transition to an Active model before the end
    /// of life time
    legacy_time: ?i64 = null,

    /// Public extended access portion of the legacy period, when users should
    /// expect higher pricing
    public_extended_access_time: ?i64 = null,

    /// Launch time when the model first becomes available
    start_of_life_time: ?i64 = null,

    /// Specifies whether a model version is available (`ACTIVE`) or deprecated
    /// (`LEGACY`.
    status: FoundationModelLifecycleStatus,

    pub const json_field_names = .{
        .end_of_life_time = "endOfLifeTime",
        .legacy_time = "legacyTime",
        .public_extended_access_time = "publicExtendedAccessTime",
        .start_of_life_time = "startOfLifeTime",
        .status = "status",
    };
};
