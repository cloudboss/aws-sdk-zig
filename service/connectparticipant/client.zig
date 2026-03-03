const aws = @import("aws");
const std = @import("std");

const cancel_participant_authentication = @import("cancel_participant_authentication.zig");
const complete_attachment_upload = @import("complete_attachment_upload.zig");
const create_participant_connection = @import("create_participant_connection.zig");
const describe_view = @import("describe_view.zig");
const disconnect_participant = @import("disconnect_participant.zig");
const get_attachment = @import("get_attachment.zig");
const get_authentication_url = @import("get_authentication_url.zig");
const get_transcript = @import("get_transcript.zig");
const send_event = @import("send_event.zig");
const send_message = @import("send_message.zig");
const start_attachment_upload = @import("start_attachment_upload.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ConnectParticipant";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Cancels the authentication session. The opted out branch of the Authenticate
    /// Customer
    /// flow block will be taken.
    ///
    /// The current supported channel is chat. This API is not supported for Apple
    /// Messages for Business, WhatsApp, or SMS chats.
    ///
    /// `ConnectionToken` is used for invoking this API instead of
    /// `ParticipantToken`.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn cancelParticipantAuthentication(self: *Self, allocator: std.mem.Allocator, input: cancel_participant_authentication.CancelParticipantAuthenticationInput, options: cancel_participant_authentication.Options) !cancel_participant_authentication.CancelParticipantAuthenticationOutput {
        return cancel_participant_authentication.execute(self, allocator, input, options);
    }

    /// Allows you to confirm that the attachment has been uploaded using the
    /// pre-signed URL
    /// provided in StartAttachmentUpload API. A conflict exception is thrown when
    /// an attachment
    /// with that identifier is already being uploaded.
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    ///
    /// `ConnectionToken` is used for invoking this API instead of
    /// `ParticipantToken`.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn completeAttachmentUpload(self: *Self, allocator: std.mem.Allocator, input: complete_attachment_upload.CompleteAttachmentUploadInput, options: complete_attachment_upload.Options) !complete_attachment_upload.CompleteAttachmentUploadOutput {
        return complete_attachment_upload.execute(self, allocator, input, options);
    }

    /// Creates the participant's connection.
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    ///
    /// For WebRTC security recommendations, see [Amazon Connect WebRTC security
    /// best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-webrtc-security).
    ///
    /// `ParticipantToken` is used for invoking this API instead of
    /// `ConnectionToken`.
    ///
    /// The participant token is valid for the lifetime of the participant – until
    /// they are
    /// part of a contact. For WebRTC participants, if they leave or are
    /// disconnected for 60
    /// seconds, a new participant needs to be created using the
    /// [CreateParticipant](https://docs.aws.amazon.com/connect/latest/APIReference/API_CreateParticipant.html) API.
    ///
    /// **For `WEBSOCKET` Type**:
    ///
    /// The response URL for has a connect expiry timeout of 100s. Clients must
    /// manually
    /// connect to the returned websocket URL and subscribe to the desired topic.
    ///
    /// For chat, you need to publish the following on the established websocket
    /// connection:
    ///
    /// `{"topic":"aws/subscribe","content":{"topics":["aws/chat"]}}`
    ///
    /// Upon websocket URL expiry, as specified in the response ConnectionExpiry
    /// parameter,
    /// clients need to call this API again to obtain a new websocket URL and
    /// perform the same
    /// steps as before.
    ///
    /// The expiry time for the connection token is different than the
    /// `ChatDurationInMinutes`. Expiry time for the connection token is 1
    /// day.
    ///
    /// **For `WEBRTC_CONNECTION` Type**:
    ///
    /// The response includes connection data required for the client application to
    /// join the
    /// call using the Amazon Chime SDK client libraries. The WebRTCConnection
    /// response contains
    /// Meeting and Attendee information needed to establish the media connection.
    ///
    /// The attendee join token in WebRTCConnection response is valid for the
    /// lifetime of the
    /// participant in the call. If a participant leaves or is disconnected for 60
    /// seconds,
    /// their participant credentials will no longer be valid, and a new participant
    /// will need
    /// to be created to rejoin the call.
    ///
    /// **Message streaming support**: This API can also be used
    /// together with the
    /// [StartContactStreaming](https://docs.aws.amazon.com/connect/latest/APIReference/API_StartContactStreaming.html) API to create a participant connection for chat
    /// contacts that are not using a websocket. For more information about message
    /// streaming,
    /// [Enable real-time chat
    /// message
    /// streaming](https://docs.aws.amazon.com/connect/latest/adminguide/chat-message-streaming.html) in the *Amazon Connect Administrator
    /// Guide*.
    ///
    /// **Multi-user web, in-app, video calling support**:
    ///
    /// For WebRTC calls, this API is used in conjunction with the CreateParticipant
    /// API to
    /// enable multi-party calling. The StartWebRTCContact API creates the initial
    /// contact and
    /// routes it to an agent, while CreateParticipant adds additional participants
    /// to the
    /// ongoing call. For more information about multi-party WebRTC calls, see
    /// [Enable multi-user web, in-app, and video
    /// calling](https://docs.aws.amazon.com/connect/latest/adminguide/enable-multiuser-inapp.html) in the *Amazon Connect
    /// Administrator Guide*.
    ///
    /// **Feature specifications**: For information about feature
    /// specifications, such as the allowed number of open websocket connections per
    /// participant
    /// or maximum number of WebRTC participants, see [Feature
    /// specifications](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#feature-limits) in the *Amazon Connect Administrator
    /// Guide*.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn createParticipantConnection(self: *Self, allocator: std.mem.Allocator, input: create_participant_connection.CreateParticipantConnectionInput, options: create_participant_connection.Options) !create_participant_connection.CreateParticipantConnectionOutput {
        return create_participant_connection.execute(self, allocator, input, options);
    }

    /// Retrieves the view for the specified view token.
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    pub fn describeView(self: *Self, allocator: std.mem.Allocator, input: describe_view.DescribeViewInput, options: describe_view.Options) !describe_view.DescribeViewOutput {
        return describe_view.execute(self, allocator, input, options);
    }

    /// Disconnects a participant.
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    ///
    /// `ConnectionToken` is used for invoking this API instead of
    /// `ParticipantToken`.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn disconnectParticipant(self: *Self, allocator: std.mem.Allocator, input: disconnect_participant.DisconnectParticipantInput, options: disconnect_participant.Options) !disconnect_participant.DisconnectParticipantOutput {
        return disconnect_participant.execute(self, allocator, input, options);
    }

    /// Provides a pre-signed URL for download of a completed attachment. This is an
    /// asynchronous API for use with active contacts.
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    ///
    /// * The participant role `CUSTOM_BOT` is not permitted to access
    /// attachments customers may upload. An `AccessDeniedException` can
    /// indicate that the participant may be a CUSTOM_BOT, and it doesn't have
    /// access to attachments.
    ///
    /// * `ConnectionToken` is used for invoking this API instead of
    /// `ParticipantToken`.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn getAttachment(self: *Self, allocator: std.mem.Allocator, input: get_attachment.GetAttachmentInput, options: get_attachment.Options) !get_attachment.GetAttachmentOutput {
        return get_attachment.execute(self, allocator, input, options);
    }

    /// Retrieves the AuthenticationUrl for the current authentication session for
    /// the
    /// AuthenticateCustomer flow block.
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    ///
    /// * This API can only be called within one minute of receiving the
    /// authenticationInitiated event.
    ///
    /// * The current supported channel is chat. This API is not supported for Apple
    /// Messages for Business, WhatsApp, or SMS chats.
    ///
    /// `ConnectionToken` is used for invoking this API instead of
    /// `ParticipantToken`.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn getAuthenticationUrl(self: *Self, allocator: std.mem.Allocator, input: get_authentication_url.GetAuthenticationUrlInput, options: get_authentication_url.Options) !get_authentication_url.GetAuthenticationUrlOutput {
        return get_authentication_url.execute(self, allocator, input, options);
    }

    /// Retrieves a transcript of the session, including details about any
    /// attachments. For
    /// information about accessing past chat contact transcripts for a persistent
    /// chat, see
    /// [Enable persistent
    /// chat](https://docs.aws.amazon.com/connect/latest/adminguide/chat-persistence.html).
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    ///
    /// If you have a process that consumes events in the transcript of an chat that
    /// has
    /// ended, note that chat transcripts contain the following event content types
    /// if the event
    /// has occurred during the chat session:
    ///
    /// * `application/vnd.amazonaws.connect.event.participant.invited`
    ///
    /// * `application/vnd.amazonaws.connect.event.participant.joined`
    ///
    /// * `application/vnd.amazonaws.connect.event.participant.left`
    ///
    /// * `application/vnd.amazonaws.connect.event.chat.ended`
    ///
    /// * `application/vnd.amazonaws.connect.event.transfer.succeeded`
    ///
    /// * `application/vnd.amazonaws.connect.event.transfer.failed`
    ///
    /// `ConnectionToken` is used for invoking this API instead of
    /// `ParticipantToken`.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn getTranscript(self: *Self, allocator: std.mem.Allocator, input: get_transcript.GetTranscriptInput, options: get_transcript.Options) !get_transcript.GetTranscriptOutput {
        return get_transcript.execute(self, allocator, input, options);
    }

    /// The `application/vnd.amazonaws.connect.event.connection.acknowledged`
    /// ContentType is no longer maintained since December 31, 2024. This event has
    /// been
    /// migrated to the
    /// [CreateParticipantConnection](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_CreateParticipantConnection.html) API using the
    /// `ConnectParticipant` field.
    ///
    /// Sends an event. Message receipts are not supported when there are more than
    /// two active
    /// participants in the chat. Using the SendEvent API for message receipts when
    /// a supervisor
    /// is barged-in will result in a conflict exception.
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    ///
    /// `ConnectionToken` is used for invoking this API instead of
    /// `ParticipantToken`.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn sendEvent(self: *Self, allocator: std.mem.Allocator, input: send_event.SendEventInput, options: send_event.Options) !send_event.SendEventOutput {
        return send_event.execute(self, allocator, input, options);
    }

    /// Sends a message.
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    ///
    /// `ConnectionToken` is used for invoking this API instead of
    /// `ParticipantToken`.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn sendMessage(self: *Self, allocator: std.mem.Allocator, input: send_message.SendMessageInput, options: send_message.Options) !send_message.SendMessageOutput {
        return send_message.execute(self, allocator, input, options);
    }

    /// Provides a pre-signed Amazon S3 URL in response for uploading the file
    /// directly to
    /// S3.
    ///
    /// For security recommendations, see [Amazon Connect Chat security best
    /// practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat).
    ///
    /// `ConnectionToken` is used for invoking this API instead of
    /// `ParticipantToken`.
    ///
    /// The Amazon Connect Participant Service APIs do not use [Signature Version 4
    /// authentication](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn startAttachmentUpload(self: *Self, allocator: std.mem.Allocator, input: start_attachment_upload.StartAttachmentUploadInput, options: start_attachment_upload.Options) !start_attachment_upload.StartAttachmentUploadOutput {
        return start_attachment_upload.execute(self, allocator, input, options);
    }

    pub fn getTranscriptPaginator(self: *Self, params: get_transcript.GetTranscriptInput) paginator.GetTranscriptPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
