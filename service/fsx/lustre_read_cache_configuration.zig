const LustreReadCacheSizingMode = @import("lustre_read_cache_sizing_mode.zig").LustreReadCacheSizingMode;

/// The configuration for the optional provisioned SSD read cache on Amazon FSx
/// for Lustre file systems
/// that use the Intelligent-Tiering storage class.
pub const LustreReadCacheConfiguration = struct {
    /// Required if `SizingMode` is set to `USER_PROVISIONED`.
    /// Specifies the size of the file system's SSD read cache, in gibibytes (GiB).
    ///
    /// The SSD read cache size is distributed across provisioned file servers in
    /// your file system. Intelligent-Tiering file systems support a minimum of 32
    /// GiB
    /// and maximum of 131072 GiB for SSD read cache size for every 4,000 MB/s of
    /// throughput
    /// capacity provisioned.
    size_gi_b: ?i32 = null,

    /// Specifies how the provisioned SSD read cache is sized, as follows:
    ///
    /// * Set to `NO_CACHE` if you do not want to use an SSD read cache with your
    ///   Intelligent-Tiering file system.
    ///
    /// * Set to `USER_PROVISIONED` to specify the exact size of your SSD read
    ///   cache.
    ///
    /// * Set to `PROPORTIONAL_TO_THROUGHPUT_CAPACITY` to have your SSD read cache
    ///   automatically sized based on your throughput capacity.
    sizing_mode: ?LustreReadCacheSizingMode = null,

    pub const json_field_names = .{
        .size_gi_b = "SizeGiB",
        .sizing_mode = "SizingMode",
    };
};
