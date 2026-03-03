/// The combination of a voice print and caller ID.
pub const VoiceProfile = struct {
    /// The time at which the voice profile was created and enrolled.
    created_timestamp: ?i64 = null,

    /// The time at which a voice profile expires unless you re-enroll the caller
    /// via the
    /// `UpdateVoiceProfile` API.
    expiration_timestamp: ?i64 = null,

    /// The time at which the voice profile was last updated.
    updated_timestamp: ?i64 = null,

    /// The ARN of the voice profile.
    voice_profile_arn: ?[]const u8 = null,

    /// The ID of the domain that contains the voice profile.
    voice_profile_domain_id: ?[]const u8 = null,

    /// The ID of the voice profile.
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
