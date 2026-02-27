/// A high-level overview of a voice profile domain.
pub const VoiceProfileDomainSummary = struct {
    /// The time at which the voice profile domain summary was created.
    created_timestamp: ?i64,

    /// Describes the voice profile domain summary.
    description: ?[]const u8,

    /// The name of the voice profile domain summary.
    name: ?[]const u8,

    /// The time at which the voice profile domain summary was last updated.
    updated_timestamp: ?i64,

    /// The ARN of a voice profile in a voice profile domain summary.
    voice_profile_domain_arn: ?[]const u8,

    /// The ID of the voice profile domain summary.
    voice_profile_domain_id: ?[]const u8,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .description = "Description",
        .name = "Name",
        .updated_timestamp = "UpdatedTimestamp",
        .voice_profile_domain_arn = "VoiceProfileDomainArn",
        .voice_profile_domain_id = "VoiceProfileDomainId",
    };
};
