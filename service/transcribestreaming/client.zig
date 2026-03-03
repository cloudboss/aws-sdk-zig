const aws = @import("aws");
const std = @import("std");

const get_medical_scribe_stream = @import("get_medical_scribe_stream.zig");
const start_call_analytics_stream_transcription = @import("start_call_analytics_stream_transcription.zig");
const start_medical_scribe_stream = @import("start_medical_scribe_stream.zig");
const start_medical_stream_transcription = @import("start_medical_stream_transcription.zig");
const start_stream_transcription = @import("start_stream_transcription.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Transcribe Streaming";

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

    /// Provides details about the specified Amazon Web Services HealthScribe
    /// streaming session.
    /// To view the status of the streaming session, check the `StreamStatus` field
    /// in the response. To get the
    /// details of post-stream analytics, including its status, check the
    /// `PostStreamAnalyticsResult` field in the response.
    pub fn getMedicalScribeStream(self: *Self, allocator: std.mem.Allocator, input: get_medical_scribe_stream.GetMedicalScribeStreamInput, options: CallOptions) !get_medical_scribe_stream.GetMedicalScribeStreamOutput {
        return get_medical_scribe_stream.execute(self, allocator, input, options);
    }

    /// Starts a bidirectional HTTP/2 or WebSocket stream where audio is streamed to
    /// Amazon Transcribe and the transcription results are streamed to your
    /// application. Use this operation
    /// for [Call
    /// Analytics](https://docs.aws.amazon.com/transcribe/latest/dg/call-analytics.html) transcriptions.
    ///
    /// The following parameters are required:
    ///
    /// * `language-code` or `identify-language`
    ///
    /// * `media-encoding`
    ///
    /// * `sample-rate`
    ///
    /// For more information on streaming with Amazon Transcribe, see [Transcribing
    /// streaming
    /// audio](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html).
    pub fn startCallAnalyticsStreamTranscription(self: *Self, allocator: std.mem.Allocator, input: start_call_analytics_stream_transcription.StartCallAnalyticsStreamTranscriptionInput, options: CallOptions) !start_call_analytics_stream_transcription.StartCallAnalyticsStreamTranscriptionOutput {
        return start_call_analytics_stream_transcription.execute(self, allocator, input, options);
    }

    /// Starts a bidirectional HTTP/2 stream, where audio is streamed to
    /// Amazon Web Services HealthScribe
    /// and the transcription results are streamed to your application.
    ///
    /// When you start a stream, you first specify the stream configuration in a
    /// `MedicalScribeConfigurationEvent`.
    /// This event includes channel definitions, encryption settings, medical scribe
    /// context, and post-stream analytics settings, such as the output
    /// configuration for aggregated transcript and clinical note generation. These
    /// are additional
    /// streaming session configurations beyond those provided in your initial start
    /// request headers. Whether you are starting a new session or resuming an
    /// existing session,
    /// your first event must be a `MedicalScribeConfigurationEvent`.
    ///
    /// After you send a `MedicalScribeConfigurationEvent`, you start `AudioEvents`
    /// and Amazon Web Services HealthScribe
    /// responds with real-time transcription results. When you are finished, to
    /// start processing the results with the post-stream analytics, send a
    /// `MedicalScribeSessionControlEvent` with a `Type` of
    /// `END_OF_SESSION` and Amazon Web Services HealthScribe starts the analytics.
    ///
    /// You can pause or resume streaming.
    /// To pause streaming, complete the input stream without sending the
    /// `MedicalScribeSessionControlEvent`.
    /// To resume streaming, call the `StartMedicalScribeStream` and specify the
    /// same SessionId you used to start the stream.
    ///
    /// The following parameters are required:
    ///
    /// * `language-code`
    ///
    /// * `media-encoding`
    ///
    /// * `media-sample-rate-hertz`
    ///
    /// For more information on streaming with
    /// Amazon Web Services HealthScribe,
    /// see [Amazon Web Services
    /// HealthScribe](https://docs.aws.amazon.com/transcribe/latest/dg/health-scribe-streaming.html).
    pub fn startMedicalScribeStream(self: *Self, allocator: std.mem.Allocator, input: start_medical_scribe_stream.StartMedicalScribeStreamInput, options: CallOptions) !start_medical_scribe_stream.StartMedicalScribeStreamOutput {
        return start_medical_scribe_stream.execute(self, allocator, input, options);
    }

    /// Starts a bidirectional HTTP/2 or WebSocket stream where audio is streamed to
    /// Amazon Transcribe Medical and the transcription results are streamed to your
    /// application.
    ///
    /// The following parameters are required:
    ///
    /// * `language-code`
    ///
    /// * `media-encoding`
    ///
    /// * `sample-rate`
    ///
    /// For more information on streaming with Amazon Transcribe Medical, see
    /// [Transcribing
    /// streaming
    /// audio](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html).
    pub fn startMedicalStreamTranscription(self: *Self, allocator: std.mem.Allocator, input: start_medical_stream_transcription.StartMedicalStreamTranscriptionInput, options: CallOptions) !start_medical_stream_transcription.StartMedicalStreamTranscriptionOutput {
        return start_medical_stream_transcription.execute(self, allocator, input, options);
    }

    /// Starts a bidirectional HTTP/2 or WebSocket stream where audio is streamed to
    /// Amazon Transcribe and the transcription results are streamed to your
    /// application.
    ///
    /// The following parameters are required:
    ///
    /// * `language-code` or `identify-language` or `identify-multiple-language`
    ///
    /// * `media-encoding`
    ///
    /// * `sample-rate`
    ///
    /// For more information on streaming with Amazon Transcribe, see [Transcribing
    /// streaming
    /// audio](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html).
    pub fn startStreamTranscription(self: *Self, allocator: std.mem.Allocator, input: start_stream_transcription.StartStreamTranscriptionInput, options: CallOptions) !start_stream_transcription.StartStreamTranscriptionOutput {
        return start_stream_transcription.execute(self, allocator, input, options);
    }
};
