const DisabledLockingSettings = @import("disabled_locking_settings.zig").DisabledLockingSettings;
const EpochLockingSettings = @import("epoch_locking_settings.zig").EpochLockingSettings;
const PipelineLockingSettings = @import("pipeline_locking_settings.zig").PipelineLockingSettings;

/// Output Locking Settings
pub const OutputLockingSettings = struct {
    disabled_locking_settings: ?DisabledLockingSettings,

    epoch_locking_settings: ?EpochLockingSettings,

    pipeline_locking_settings: ?PipelineLockingSettings,

    pub const json_field_names = .{
        .disabled_locking_settings = "DisabledLockingSettings",
        .epoch_locking_settings = "EpochLockingSettings",
        .pipeline_locking_settings = "PipelineLockingSettings",
    };
};
