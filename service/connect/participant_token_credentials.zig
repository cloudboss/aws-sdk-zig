/// The credentials used by the participant.
pub const ParticipantTokenCredentials = struct {
    /// The expiration of the token. It's specified in ISO 8601 format:
    /// yyyy-MM-ddThh:mm:ss.SSSZ. For example,
    /// 2019-11-08T02:41:28.172Z.
    expiry: ?[]const u8 = null,

    /// The token used by the chat participant to call
    /// [CreateParticipantConnection](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_CreateParticipantConnection.html). The participant token is valid for the lifetime of a chat participant.
    participant_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .expiry = "Expiry",
        .participant_token = "ParticipantToken",
    };
};
