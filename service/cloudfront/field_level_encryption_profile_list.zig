const FieldLevelEncryptionProfileSummary = @import("field_level_encryption_profile_summary.zig").FieldLevelEncryptionProfileSummary;

/// List of field-level encryption profiles.
pub const FieldLevelEncryptionProfileList = struct {
    /// The field-level encryption profile items.
    items: ?[]const FieldLevelEncryptionProfileSummary,

    /// The maximum number of field-level encryption profiles you want in the
    /// response body.
    max_items: i32,

    /// If there are more elements to be listed, this element is present and
    /// contains the value that you can use for the `Marker` request parameter to
    /// continue listing your profiles where you left off.
    next_marker: ?[]const u8,

    /// The number of field-level encryption profiles.
    quantity: i32,
};
