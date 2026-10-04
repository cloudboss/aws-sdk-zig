/// Contains metadata about the client that streamed the video for a Face
/// Liveness
/// session.
pub const SessionMetadata = struct {
    /// The type of SDK that was used to stream the video for the Face Liveness
    /// session.
    ///
    /// This value is self-reported by the client that streamed the session, and
    /// Amazon Rekognition doesn't verify it. Don't rely on it for authentication,
    /// authorization, or any
    /// other security decision.
    sdk_type: []const u8,

    pub const json_field_names = .{
        .sdk_type = "SDKType",
    };
};
