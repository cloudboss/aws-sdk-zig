/// A key-value pair that provides additional metadata about a capacity
/// allocation.
pub const CapacityAllocationMetadataEntry = struct {
    /// The key of the metadata entry.
    key: ?[]const u8 = null,

    /// The value of the metadata entry.
    value: ?[]const u8 = null,
};
