/// Information about a specified personal access token (PAT).
pub const AccessTokenSummary = struct {
    /// The date and time when the personal access token will expire, in coordinated
    /// universal time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    expires_time: ?i64 = null,

    /// The system-generated ID of the personal access token.
    id: []const u8,

    /// The friendly name of the personal access token.
    name: []const u8,

    pub const json_field_names = .{
        .expires_time = "expiresTime",
        .id = "id",
        .name = "name",
    };
};
