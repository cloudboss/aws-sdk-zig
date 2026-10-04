const IteratorPosition = @import("iterator_position.zig").IteratorPosition;

/// Provides information about the current iterator.
pub const IteratorDescription = struct {
    /// Indicates the current iterator's position within the shard. The possible
    /// values are:
    ///
    /// * `AT_TIP` - No more records are currently available.
    /// * `BEHIND_TIP` - Additional records may be available.
    ///
    /// Stream progresses in absence of customer records. `BEHIND_TIP` with an empty
    /// `changeRecords` list indicates the stream is progressing but no customer
    /// records are available at this position. Continue polling normally.
    iterator_position: ?IteratorPosition = null,

    pub const json_field_names = .{
        .iterator_position = "iteratorPosition",
    };
};
