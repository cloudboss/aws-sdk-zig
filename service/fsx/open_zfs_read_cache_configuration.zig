const OpenZFSReadCacheSizingMode = @import("open_zfs_read_cache_sizing_mode.zig").OpenZFSReadCacheSizingMode;

/// The configuration for the optional provisioned SSD read cache on Amazon FSx
/// for OpenZFS file systems that use the Intelligent-Tiering storage class.
pub const OpenZFSReadCacheConfiguration = struct {
    /// Required if `SizingMode` is set to `USER_PROVISIONED`. Specifies the size of
    /// the file system's SSD read cache, in gibibytes (GiB).
    size_gi_b: ?i32,

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
    sizing_mode: ?OpenZFSReadCacheSizingMode,

    pub const json_field_names = .{
        .size_gi_b = "SizeGiB",
        .sizing_mode = "SizingMode",
    };
};
