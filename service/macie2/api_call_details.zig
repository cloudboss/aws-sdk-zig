/// Provides information about an API operation that an entity invoked for an
/// affected resource.
pub const ApiCallDetails = struct {
    /// The name of the operation that was invoked most recently and produced the
    /// finding.
    api: ?[]const u8 = null,

    /// The URL of the Amazon Web Services service that provides the operation, for
    /// example: s3.amazonaws.com.
    api_service_name: ?[]const u8 = null,

    /// The first date and time, in UTC and extended ISO 8601 format, when any
    /// operation was invoked and produced the finding.
    first_seen: ?i64 = null,

    /// The most recent date and time, in UTC and extended ISO 8601 format, when the
    /// specified operation (api) was invoked and produced the finding.
    last_seen: ?i64 = null,

    pub const json_field_names = .{
        .api = "api",
        .api_service_name = "apiServiceName",
        .first_seen = "firstSeen",
        .last_seen = "lastSeen",
    };
};
