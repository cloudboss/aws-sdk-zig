/// Global Configuration Output Locking Mode
pub const GlobalConfigurationOutputLockingMode = enum {
    epoch_locking,
    pipeline_locking,
    disabled,

    pub const json_field_names = .{
        .epoch_locking = "EPOCH_LOCKING",
        .pipeline_locking = "PIPELINE_LOCKING",
        .disabled = "DISABLED",
    };
};
