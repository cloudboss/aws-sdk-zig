const FieldLevelEncryptionSummary = @import("field_level_encryption_summary.zig").FieldLevelEncryptionSummary;

/// List of field-level encryption configurations.
pub const FieldLevelEncryptionList = struct {
    /// An array of field-level encryption items.
    items: ?[]const FieldLevelEncryptionSummary = null,

    /// The maximum number of elements you want in the response body.
    max_items: i32,

    /// If there are more elements to be listed, this element is present and
    /// contains the value that you can use for the `Marker` request parameter to
    /// continue listing your configurations where you left off.
    next_marker: ?[]const u8 = null,

    /// The number of field-level encryption items.
    quantity: i32,
};
