const SpeakerStatus = @import("speaker_status.zig").SpeakerStatus;

/// Contains all the information about a speaker.
pub const Speaker = struct {
    /// A timestamp of when the speaker was created.
    created_at: ?i64,

    /// The client-provided identifier for the speaker.
    customer_speaker_id: ?[]const u8,

    /// The identifier of the domain that contains the speaker.
    domain_id: ?[]const u8,

    /// The service-generated identifier for the speaker.
    generated_speaker_id: ?[]const u8,

    /// The timestamp of when the speaker was last accessed for enrollment,
    /// re-enrollment or a
    /// successful authentication. This timestamp is accurate to one hour.
    last_accessed_at: ?i64,

    /// The current status of the speaker.
    status: ?SpeakerStatus,

    /// A timestamp of the speaker's last update.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .customer_speaker_id = "CustomerSpeakerId",
        .domain_id = "DomainId",
        .generated_speaker_id = "GeneratedSpeakerId",
        .last_accessed_at = "LastAccessedAt",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
