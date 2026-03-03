const aws = @import("aws");
const std = @import("std");

const delete_session = @import("delete_session.zig");
const get_session = @import("get_session.zig");
const put_session = @import("put_session.zig");
const recognize_text = @import("recognize_text.zig");
const recognize_utterance = @import("recognize_utterance.zig");
const start_conversation = @import("start_conversation.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Lex Runtime V2";

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

    /// Removes session information for a specified bot, alias, and user ID.
    ///
    /// You can use this operation to restart a conversation with a bot.
    /// When you remove a session, the entire history of the session is removed
    /// so that you can start again.
    ///
    /// You don't need to delete a session. Sessions have a time limit and
    /// will expire. Set the session time limit when you create the bot. The
    /// default is 5 minutes, but you can specify anything between 1 minute and
    /// 24 hours.
    ///
    /// If you specify a bot or alias ID that doesn't exist, you receive a
    /// `BadRequestException.`
    ///
    /// If the locale doesn't exist in the bot, or if the locale hasn't been
    /// enables for the alias, you receive a
    /// `BadRequestException`.
    pub fn deleteSession(self: *Self, allocator: std.mem.Allocator, input: delete_session.DeleteSessionInput, options: CallOptions) !delete_session.DeleteSessionOutput {
        return delete_session.execute(self, allocator, input, options);
    }

    /// Returns session information for a specified bot, alias, and
    /// user.
    ///
    /// For example, you can use this operation to retrieve session
    /// information for a user that has left a long-running session in
    /// use.
    ///
    /// If the bot, alias, or session identifier doesn't exist, Amazon Lex V2
    /// returns a `BadRequestException`. If the locale doesn't exist
    /// or is not enabled for the alias, you receive a
    /// `BadRequestException`.
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: CallOptions) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// Creates a new session or modifies an existing session with an Amazon Lex V2
    /// bot. Use this operation to enable your application to set the state of
    /// the bot.
    pub fn putSession(self: *Self, allocator: std.mem.Allocator, input: put_session.PutSessionInput, options: CallOptions) !put_session.PutSessionOutput {
        return put_session.execute(self, allocator, input, options);
    }

    /// Sends user input to Amazon Lex V2. Client applications use this API to send
    /// requests to Amazon Lex V2 at runtime. Amazon Lex V2 then interprets the user
    /// input
    /// using the machine learning model that it build for the bot.
    ///
    /// In response, Amazon Lex V2 returns the next message to convey to the user
    /// and an optional response card to display.
    ///
    /// If the optional post-fulfillment response is specified, the messages
    /// are returned as follows. For more information, see
    /// [PostFulfillmentStatusSpecification](https://docs.aws.amazon.com/lexv2/latest/dg/API_PostFulfillmentStatusSpecification.html).
    ///
    /// * **Success message** - Returned if
    /// the Lambda function completes successfully and the intent state is
    /// fulfilled or ready fulfillment if the message is present.
    ///
    /// * **Failed message** - The failed
    /// message is returned if the Lambda function throws an exception or
    /// if the Lambda function returns a failed intent state without a
    /// message.
    ///
    /// * **Timeout message** - If you
    /// don't configure a timeout message and a timeout, and the Lambda
    /// function doesn't return within 30 seconds, the timeout message is
    /// returned. If you configure a timeout, the timeout message is
    /// returned when the period times out.
    ///
    /// For more information, see [Completion
    /// message](https://docs.aws.amazon.com/lexv2/latest/dg/streaming-progress.html#progress-complete.html).
    pub fn recognizeText(self: *Self, allocator: std.mem.Allocator, input: recognize_text.RecognizeTextInput, options: CallOptions) !recognize_text.RecognizeTextOutput {
        return recognize_text.execute(self, allocator, input, options);
    }

    /// Sends user input to Amazon Lex V2. You can send text or speech. Clients use
    /// this API to send text and audio requests to Amazon Lex V2 at runtime. Amazon
    /// Lex V2
    /// interprets the user input using the machine learning model built for
    /// the bot.
    ///
    /// The following request fields must be compressed with gzip and then
    /// base64 encoded before you send them to Amazon Lex V2.
    ///
    /// * requestAttributes
    ///
    /// * sessionState
    ///
    /// The following response fields are compressed using gzip and then
    /// base64 encoded by Amazon Lex V2. Before you can use these fields, you must
    /// decode and decompress them.
    ///
    /// * inputTranscript
    ///
    /// * interpretations
    ///
    /// * messages
    ///
    /// * requestAttributes
    ///
    /// * sessionState
    ///
    /// The example contains a Java application that compresses and encodes
    /// a Java object to send to Amazon Lex V2, and a second that decodes and
    /// decompresses a response from Amazon Lex V2.
    ///
    /// If the optional post-fulfillment response is specified, the messages
    /// are returned as follows. For more information, see
    /// [PostFulfillmentStatusSpecification](https://docs.aws.amazon.com/lexv2/latest/dg/API_PostFulfillmentStatusSpecification.html).
    ///
    /// * **Success message** - Returned if
    /// the Lambda function completes successfully and the intent state is
    /// fulfilled or ready fulfillment if the message is present.
    ///
    /// * **Failed message** - The failed
    /// message is returned if the Lambda function throws an exception or
    /// if the Lambda function returns a failed intent state without a
    /// message.
    ///
    /// * **Timeout message** - If you
    /// don't configure a timeout message and a timeout, and the Lambda
    /// function doesn't return within 30 seconds, the timeout message is
    /// returned. If you configure a timeout, the timeout message is
    /// returned when the period times out.
    ///
    /// For more information, see [Completion
    /// message](https://docs.aws.amazon.com/lexv2/latest/dg/streaming-progress.html#progress-complete.html).
    pub fn recognizeUtterance(self: *Self, allocator: std.mem.Allocator, input: recognize_utterance.RecognizeUtteranceInput, options: CallOptions) !recognize_utterance.RecognizeUtteranceOutput {
        return recognize_utterance.execute(self, allocator, input, options);
    }

    /// Starts an HTTP/2 bidirectional event stream that enables you to send
    /// audio, text, or DTMF input in real time. After your application starts
    /// a conversation, users send input to Amazon Lex V2 as a stream of events.
    /// Amazon Lex V2
    /// processes the incoming events and responds with streaming text or audio
    /// events.
    ///
    /// Audio input must be in the following format: `audio/lpcm
    /// sample-rate=8000 sample-size-bits=16 channel-count=1;
    /// is-big-endian=false`.
    ///
    /// If the optional post-fulfillment response is specified, the messages
    /// are returned as follows. For more information, see
    /// [PostFulfillmentStatusSpecification](https://docs.aws.amazon.com/lexv2/latest/dg/API_PostFulfillmentStatusSpecification.html).
    ///
    /// * **Success message** - Returned if
    /// the Lambda function completes successfully and the intent state is
    /// fulfilled or ready fulfillment if the message is present.
    ///
    /// * **Failed message** - The failed
    /// message is returned if the Lambda function throws an exception or
    /// if the Lambda function returns a failed intent state without a
    /// message.
    ///
    /// * **Timeout message** - If you
    /// don't configure a timeout message and a timeout, and the Lambda
    /// function doesn't return within 30 seconds, the timeout message is
    /// returned. If you configure a timeout, the timeout message is
    /// returned when the period times out.
    ///
    /// For more information, see [Completion
    /// message](https://docs.aws.amazon.com/lexv2/latest/dg/streaming-progress.html#progress-complete.html).
    ///
    /// If the optional update message is configured, it is played at the
    /// specified frequency while the Lambda function is running and the update
    /// message state is active. If the fulfillment update message is not
    /// active, the Lambda function runs with a 30 second timeout.
    ///
    /// For more information, see [Update message
    /// ](https://docs.aws.amazon.com/lexv2/latest/dg/streaming-progress.html#progress-update.html)
    ///
    /// The `StartConversation` operation is supported only in
    /// the following SDKs:
    ///
    /// * [AWS SDK for
    ///   C++](https://docs.aws.amazon.com/goto/SdkForCpp/runtime.lex.v2-2020-08-07/StartConversation)
    ///
    /// * [AWS SDK for Java
    ///   V2](https://docs.aws.amazon.com/goto/SdkForJavaV2/runtime.lex.v2-2020-08-07/StartConversation)
    ///
    /// * [AWS SDK for Ruby
    ///   V3](https://docs.aws.amazon.com/goto/SdkForRubyV3/runtime.lex.v2-2020-08-07/StartConversation)
    pub fn startConversation(self: *Self, allocator: std.mem.Allocator, input: start_conversation.StartConversationInput, options: CallOptions) !start_conversation.StartConversationOutput {
        return start_conversation.execute(self, allocator, input, options);
    }
};
