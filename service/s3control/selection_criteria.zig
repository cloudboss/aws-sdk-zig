pub const SelectionCriteria = struct {
    /// A container for the delimiter of the selection criteria being used.
    delimiter: ?[]const u8,

    /// The max depth of the selection criteria
    max_depth: ?i32,

    /// The minimum number of storage bytes percentage whose metrics will be
    /// selected.
    ///
    /// You must choose a value greater than or equal to `1.0`.
    min_storage_bytes_percentage: ?f64,
};
