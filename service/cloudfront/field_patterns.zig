/// A complex data type that includes the field patterns to match for
/// field-level encryption.
pub const FieldPatterns = struct {
    /// An array of the field-level encryption field patterns.
    items: ?[]const []const u8,

    /// The number of field-level encryption field patterns.
    quantity: i32,
};
