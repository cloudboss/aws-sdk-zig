/// The refresh cache information for the file share or FSx file systems.
pub const CacheAttributes = struct {
    /// Refreshes a file share's cache by using Time To Live (TTL). TTL is the
    /// length of
    /// time since the last refresh after which access to the directory would cause
    /// the file
    /// gateway to first refresh that directory's contents from the Amazon S3 bucket
    /// or Amazon FSx file system. The TTL duration is in seconds.
    ///
    /// Valid Values:0, 300 to 2,592,000 seconds (5 minutes to 30 days)
    cache_stale_timeout_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .cache_stale_timeout_in_seconds = "CacheStaleTimeoutInSeconds",
    };
};
