pub const SelectionCriteria = struct {
    /// A container for the delimiter of the selection criteria being used.
    delimiter: ?[]const u8 = null,

    /// The max depth of the selection criteria
    max_depth: ?i32 = null,

    /// The minimum percentage of total bucket storage that a prefix must hold for
    /// its metrics to be included.
    min_storage_bytes_percentage: ?f64 = null,
};
