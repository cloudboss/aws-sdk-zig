/// The configuration for the number of ElastiCache Processing Units (ECPU) the
/// cache can consume per second.
pub const ECPUPerSecond = struct {
    /// The configuration for the maximum number of ECPUs the cache can consume per
    /// second.
    maximum: ?i32,

    /// The configuration for the minimum number of ECPUs the cache should be able
    /// consume per second.
    minimum: ?i32,
};
