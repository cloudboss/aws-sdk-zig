/// Provides a subset of information about an allow list.
pub const AllowListSummary = struct {
    /// The Amazon Resource Name (ARN) of the allow list.
    arn: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the allow list
    /// was created in Amazon Macie.
    created_at: ?i64 = null,

    /// The custom description of the allow list.
    description: ?[]const u8 = null,

    /// The unique identifier for the allow list.
    id: ?[]const u8 = null,

    /// The custom name of the allow list.
    name: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the allow
    /// list's settings were most recently changed in Amazon Macie.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .id = "id",
        .name = "name",
        .updated_at = "updatedAt",
    };
};
