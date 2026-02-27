const ContentTypeProfileConfig = @import("content_type_profile_config.zig").ContentTypeProfileConfig;
const QueryArgProfileConfig = @import("query_arg_profile_config.zig").QueryArgProfileConfig;

/// A summary of a field-level encryption item.
pub const FieldLevelEncryptionSummary = struct {
    /// An optional comment about the field-level encryption item. The comment
    /// cannot be longer than 128 characters.
    comment: ?[]const u8,

    /// A summary of a content type-profile mapping.
    content_type_profile_config: ?ContentTypeProfileConfig,

    /// The unique ID of a field-level encryption item.
    id: []const u8,

    /// The last time that the summary of field-level encryption items was modified.
    last_modified_time: i64,

    /// A summary of a query argument-profile mapping.
    query_arg_profile_config: ?QueryArgProfileConfig,
};
