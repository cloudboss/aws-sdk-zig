const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;

/// A collection of voice profiles.
pub const VoiceProfileDomain = struct {
    /// The time at which the voice profile domain was created.
    created_timestamp: ?i64 = null,

    /// The description of the voice profile domain.
    description: ?[]const u8 = null,

    /// The name of the voice profile domain.
    name: ?[]const u8 = null,

    /// A structure that contains the configuration settings for server-side
    /// encryption.
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// The time at which the voice profile was last updated.
    updated_timestamp: ?i64 = null,

    /// The voice profile domain's Amazon Resource Number (ARN).
    voice_profile_domain_arn: ?[]const u8 = null,

    /// The ID of the voice profile domain.
    voice_profile_domain_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .description = "Description",
        .name = "Name",
        .server_side_encryption_configuration = "ServerSideEncryptionConfiguration",
        .updated_timestamp = "UpdatedTimestamp",
        .voice_profile_domain_arn = "VoiceProfileDomainArn",
        .voice_profile_domain_id = "VoiceProfileDomainId",
    };
};
