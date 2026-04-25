const VersionFailureReasonCode = @import("version_failure_reason_code.zig").VersionFailureReasonCode;
const VersionStatus = @import("version_status.zig").VersionStatus;

/// Version information for a contact.
pub const ContactVersion = struct {
    /// Time the contact version was activated in UTC. A version is activated when
    /// it becomes the current active version of the contact.
    activated: ?i64 = null,

    /// Time the contact version was created in UTC.
    created: ?i64 = null,

    /// List of failure codes for the contact version.
    failure_codes: ?[]const VersionFailureReasonCode = null,

    /// Failure message for the contact version.
    failure_message: ?[]const u8 = null,

    /// Time the contact version was last updated in UTC.
    last_updated: ?i64 = null,

    /// Status of the contact version.
    status: ?VersionStatus = null,

    /// Time the contact version was superseded in UTC. A version is superseded when
    /// a newer version becomes active.
    superseded: ?i64 = null,

    /// Version ID of a contact.
    version_id: ?i32 = null,

    pub const json_field_names = .{
        .activated = "activated",
        .created = "created",
        .failure_codes = "failureCodes",
        .failure_message = "failureMessage",
        .last_updated = "lastUpdated",
        .status = "status",
        .superseded = "superseded",
        .version_id = "versionId",
    };
};
