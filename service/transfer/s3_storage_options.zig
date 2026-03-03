const DirectoryListingOptimization = @import("directory_listing_optimization.zig").DirectoryListingOptimization;

/// The Amazon S3 storage options that are configured for your server.
pub const S3StorageOptions = struct {
    /// Specifies whether or not performance for your Amazon S3 directories is
    /// optimized.
    ///
    /// * If using the console, this is enabled by default.
    /// * If using the API or CLI, this is disabled by default.
    ///
    /// By default, home directory mappings have a `TYPE` of `DIRECTORY`. If you
    /// enable this option, you would then need to explicitly set the
    /// `HomeDirectoryMapEntry` `Type` to `FILE` if you want a mapping to have a
    /// file target.
    directory_listing_optimization: ?DirectoryListingOptimization = null,

    pub const json_field_names = .{
        .directory_listing_optimization = "DirectoryListingOptimization",
    };
};
