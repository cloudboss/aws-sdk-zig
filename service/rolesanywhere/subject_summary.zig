/// A summary representation of subjects.
pub const SubjectSummary = struct {
    /// The ISO-8601 time stamp of when the certificate was first used in a
    /// temporary credential request.
    created_at: ?i64 = null,

    /// The enabled status of the subject.
    enabled: ?bool = null,

    /// The ISO-8601 time stamp of when the certificate was last used in a temporary
    /// credential request.
    last_seen_at: ?i64 = null,

    /// The ARN of the resource.
    subject_arn: ?[]const u8 = null,

    /// The id of the resource.
    subject_id: ?[]const u8 = null,

    /// The ISO-8601 timestamp when the subject was last updated.
    updated_at: ?i64 = null,

    /// The x509 principal identifier of the authenticating certificate.
    x_509_subject: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .enabled = "enabled",
        .last_seen_at = "lastSeenAt",
        .subject_arn = "subjectArn",
        .subject_id = "subjectId",
        .updated_at = "updatedAt",
        .x_509_subject = "x509Subject",
    };
};
