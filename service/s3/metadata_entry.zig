/// A metadata key-value pair to store with an object.
pub const MetadataEntry = struct {
    /// Name of the object.
    name: ?[]const u8 = null,

    /// Value of the object.
    value: ?[]const u8 = null,
};
