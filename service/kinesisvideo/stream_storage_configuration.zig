const DefaultStorageTier = @import("default_storage_tier.zig").DefaultStorageTier;

/// The configuration for stream storage, including the default storage tier for
/// stream data. This configuration determines how stream data is stored and
/// accessed, with different tiers offering varying levels of performance and
/// cost optimization.
pub const StreamStorageConfiguration = struct {
    /// The default storage tier for the stream data. This setting determines the
    /// storage class used for stream data, affecting both performance
    /// characteristics and storage costs.
    ///
    /// Available storage tiers:
    ///
    /// * `HOT` - Optimized for frequent access with the lowest latency and highest
    ///   performance. Ideal for real-time applications and frequently accessed
    ///   data.
    ///
    /// * `WARM` - Balanced performance and cost for moderately accessed data.
    ///   Suitable for data that is accessed regularly but not continuously.
    default_storage_tier: DefaultStorageTier,

    pub const json_field_names = .{
        .default_storage_tier = "DefaultStorageTier",
    };
};
