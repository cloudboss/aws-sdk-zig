const aws = @import("aws");

const SessionState = @import("session_state.zig").SessionState;
const Message = @import("message.zig").Message;

/// The initial event sent from the application to Amazon Lex V2 to configure
/// the conversation, including session and request attributes and the
/// response content type.
pub const ConfigurationEvent = struct {
    /// A timestamp set by the client of the date and time that the event
    /// was sent to Amazon Lex V2.
    client_timestamp_millis: i64 = 0,

    /// Determines whether Amazon Lex V2 should send audio responses to the client
    /// application.
    ///
    /// Set this field to false when the client is operating in a playback
    /// mode where audio responses are played to the user. If the client isn't
    /// operating in playback mode, such as a text chat application, set this
    /// to true so that Amazon Lex V2 doesn't wait for the prompt to finish playing
    /// on
    /// the client.
    disable_playback: bool = false,

    /// A unique identifier that your application assigns to the event. You
    /// can use this to identify events in logs.
    event_id: ?[]const u8 = null,

    /// Request-specific information passed between the client application
    /// and Amazon Lex V2.
    ///
    /// The namespace `x-amz-lex:` is reserved for special
    /// attributes. Don't create any request attributes for prefix
    /// `x-amz-lex:`.
    request_attributes: ?[]const aws.map.StringMapEntry = null,

    /// The message that Amazon Lex V2 returns in the response can be either text or
    /// speech based on the `responseContentType` value.
    ///
    /// * If the value is `text/plain;charset=utf-8`, Amazon Lex V2
    /// returns text in the response.
    ///
    /// * If the value begins with `audio/`, Amazon Lex V2 returns
    /// speech in the response. Amazon Lex V2 uses Amazon Polly to generate the
    /// speech
    /// using the configuration that you specified in the
    /// `requestContentType` parameter. For example, if you
    /// specify `audio/mpeg` as the value, Amazon Lex V2 returns
    /// speech in the MPEG format.
    ///
    /// * If the value is `audio/pcm`, the speech returned is
    /// audio/pcm in 16-bit, little-endian format.
    ///
    /// * The following are the accepted values:
    ///
    /// * audio/mpeg
    ///
    /// * audio/ogg
    ///
    /// * audio/pcm
    ///
    /// * audio/* (defaults to mpeg)
    ///
    /// * text/plain; charset=utf-8
    response_content_type: []const u8,

    session_state: ?SessionState = null,

    /// A list of messages to send to the user.
    ///
    /// If you set the `welcomeMessage` field, you must also set
    /// the [
    /// `DialogAction`
    /// ](https://docs.aws.amazon.com/lexv2/latest/dg/API_runtime_DialogAction.html)
    /// structure's [
    /// `type`
    /// ](https://docs.aws.amazon.com/lexv2/latest/dg/API_runtime_DialogAction.html#lexv2-Type-runtime_DialogAction-type) field.
    welcome_messages: ?[]const Message = null,

    pub const json_field_names = .{
        .client_timestamp_millis = "clientTimestampMillis",
        .disable_playback = "disablePlayback",
        .event_id = "eventId",
        .request_attributes = "requestAttributes",
        .response_content_type = "responseContentType",
        .session_state = "sessionState",
        .welcome_messages = "welcomeMessages",
    };
};
