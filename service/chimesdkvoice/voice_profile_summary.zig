/// A high-level summary of a voice profile.
pub const VoiceProfileSummary = struct {
    /// The time at which a voice profile summary was created.
    created_timestamp: ?i64 = null,

    /// Extends the life of the voice profile. You can use `UpdateVoiceProfile` to
    /// refresh an existing voice profile's voice print and extend the life of the
    /// summary.
    expiration_timestamp: ?i64 = null,

    /// The time at which a voice profile summary was last updated.
    updated_timestamp: ?i64 = null,

    /// The ARN of the voice profile in a voice profile summary.
    voice_profile_arn: ?[]const u8 = null,

    /// The ID of the voice profile domain in a voice profile summary.
    voice_profile_domain_id: ?[]const u8 = null,

    /// The ID of the voice profile in a voice profile summary.
    voice_profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .expiration_timestamp = "ExpirationTimestamp",
        .updated_timestamp = "UpdatedTimestamp",
        .voice_profile_arn = "VoiceProfileArn",
        .voice_profile_domain_id = "VoiceProfileDomainId",
        .voice_profile_id = "VoiceProfileId",
    };
};
