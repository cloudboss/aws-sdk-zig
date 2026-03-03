const CredentialSummary = @import("credential_summary.zig").CredentialSummary;
const InstanceProperty = @import("instance_property.zig").InstanceProperty;

/// The state of the subject after a read or write operation.
pub const SubjectDetail = struct {
    /// The ISO-8601 timestamp when the subject was created.
    created_at: ?i64 = null,

    /// The temporary session credentials vended at the last authenticating call
    /// with this subject.
    credentials: ?[]const CredentialSummary = null,

    /// The enabled status of the subject.
    enabled: ?bool = null,

    /// The specified instance properties associated with the request.
    instance_properties: ?[]const InstanceProperty = null,

    /// The ISO-8601 timestamp of the last time this subject requested temporary
    /// session credentials.
    last_seen_at: ?i64 = null,

    /// The ARN of the resource.
    subject_arn: ?[]const u8 = null,

    /// The id of the resource
    subject_id: ?[]const u8 = null,

    /// The ISO-8601 timestamp when the subject was last updated.
    updated_at: ?i64 = null,

    /// The x509 principal identifier of the authenticating certificate.
    x_509_subject: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .credentials = "credentials",
        .enabled = "enabled",
        .instance_properties = "instanceProperties",
        .last_seen_at = "lastSeenAt",
        .subject_arn = "subjectArn",
        .subject_id = "subjectId",
        .updated_at = "updatedAt",
        .x_509_subject = "x509Subject",
    };
};
