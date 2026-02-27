/// Retention properties contain the duration for which your time-series data
/// must be stored
/// in the magnetic store and the memory store.
pub const RetentionProperties = struct {
    /// The duration for which data must be stored in the magnetic store.
    magnetic_store_retention_period_in_days: i64,

    /// The duration for which data must be stored in the memory store.
    memory_store_retention_period_in_hours: i64,

    pub const json_field_names = .{
        .magnetic_store_retention_period_in_days = "MagneticStoreRetentionPeriodInDays",
        .memory_store_retention_period_in_hours = "MemoryStoreRetentionPeriodInHours",
    };
};
