const ContentTypeProfileConfig = @import("content_type_profile_config.zig").ContentTypeProfileConfig;
const QueryArgProfileConfig = @import("query_arg_profile_config.zig").QueryArgProfileConfig;

/// A complex data type that includes the profile configurations specified for
/// field-level encryption.
pub const FieldLevelEncryptionConfig = struct {
    /// A unique number that ensures the request can't be replayed.
    caller_reference: []const u8,

    /// An optional comment about the configuration. The comment cannot be longer
    /// than 128 characters.
    comment: ?[]const u8,

    /// A complex data type that specifies when to forward content if a content type
    /// isn't recognized and profiles to use as by default in a request if a query
    /// argument doesn't specify a profile to use.
    content_type_profile_config: ?ContentTypeProfileConfig,

    /// A complex data type that specifies when to forward content if a profile
    /// isn't found and the profile that can be provided as a query argument in a
    /// request.
    query_arg_profile_config: ?QueryArgProfileConfig,
};
