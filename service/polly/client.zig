const aws = @import("aws");
const std = @import("std");

const delete_lexicon = @import("delete_lexicon.zig");
const describe_voices = @import("describe_voices.zig");
const get_lexicon = @import("get_lexicon.zig");
const get_speech_synthesis_task = @import("get_speech_synthesis_task.zig");
const list_lexicons = @import("list_lexicons.zig");
const list_speech_synthesis_tasks = @import("list_speech_synthesis_tasks.zig");
const put_lexicon = @import("put_lexicon.zig");
const start_speech_synthesis_task = @import("start_speech_synthesis_task.zig");
const synthesize_speech = @import("synthesize_speech.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Polly";

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

    /// Deletes the specified pronunciation lexicon stored in an Amazon Web Services
    /// Region. A lexicon which has been deleted is not available for
    /// speech synthesis, nor is it possible to retrieve it using either the
    /// `GetLexicon` or `ListLexicon` APIs.
    ///
    /// For more information, see [Managing
    /// Lexicons](https://docs.aws.amazon.com/polly/latest/dg/managing-lexicons.html).
    pub fn deleteLexicon(self: *Self, allocator: std.mem.Allocator, input: delete_lexicon.DeleteLexiconInput, options: CallOptions) !delete_lexicon.DeleteLexiconOutput {
        return delete_lexicon.execute(self, allocator, input, options);
    }

    /// Returns the list of voices that are available for use when
    /// requesting speech synthesis. Each voice speaks a specified language, is
    /// either male or female, and is identified by an ID, which is the ASCII
    /// version of the voice name.
    ///
    /// When synthesizing speech ( `SynthesizeSpeech` ), you
    /// provide the voice ID for the voice you want from the list of voices
    /// returned by `DescribeVoices`.
    ///
    /// For example, you want your news reader application to read news in
    /// a specific language, but giving a user the option to choose the voice.
    /// Using the `DescribeVoices` operation you can provide the user
    /// with a list of available voices to select from.
    ///
    /// You can optionally specify a language code to filter the available
    /// voices. For example, if you specify `en-US`, the operation
    /// returns a list of all available US English voices.
    ///
    /// This operation requires permissions to perform the
    /// `polly:DescribeVoices` action.
    pub fn describeVoices(self: *Self, allocator: std.mem.Allocator, input: describe_voices.DescribeVoicesInput, options: CallOptions) !describe_voices.DescribeVoicesOutput {
        return describe_voices.execute(self, allocator, input, options);
    }

    /// Returns the content of the specified pronunciation lexicon stored
    /// in an Amazon Web Services Region. For more information, see [Managing
    /// Lexicons](https://docs.aws.amazon.com/polly/latest/dg/managing-lexicons.html).
    pub fn getLexicon(self: *Self, allocator: std.mem.Allocator, input: get_lexicon.GetLexiconInput, options: CallOptions) !get_lexicon.GetLexiconOutput {
        return get_lexicon.execute(self, allocator, input, options);
    }

    /// Retrieves a specific SpeechSynthesisTask object based on its TaskID.
    /// This object contains information about the given speech synthesis task,
    /// including the status of the task, and a link to the S3 bucket containing
    /// the output of the task.
    pub fn getSpeechSynthesisTask(self: *Self, allocator: std.mem.Allocator, input: get_speech_synthesis_task.GetSpeechSynthesisTaskInput, options: CallOptions) !get_speech_synthesis_task.GetSpeechSynthesisTaskOutput {
        return get_speech_synthesis_task.execute(self, allocator, input, options);
    }

    /// Returns a list of pronunciation lexicons stored in an Amazon Web Services
    /// Region. For more information, see [Managing
    /// Lexicons](https://docs.aws.amazon.com/polly/latest/dg/managing-lexicons.html).
    pub fn listLexicons(self: *Self, allocator: std.mem.Allocator, input: list_lexicons.ListLexiconsInput, options: CallOptions) !list_lexicons.ListLexiconsOutput {
        return list_lexicons.execute(self, allocator, input, options);
    }

    /// Returns a list of SpeechSynthesisTask objects ordered by their
    /// creation date. This operation can filter the tasks by their status, for
    /// example, allowing users to list only tasks that are completed.
    pub fn listSpeechSynthesisTasks(self: *Self, allocator: std.mem.Allocator, input: list_speech_synthesis_tasks.ListSpeechSynthesisTasksInput, options: CallOptions) !list_speech_synthesis_tasks.ListSpeechSynthesisTasksOutput {
        return list_speech_synthesis_tasks.execute(self, allocator, input, options);
    }

    /// Stores a pronunciation lexicon in an Amazon Web Services Region. If
    /// a lexicon with the same name already exists in the region, it is
    /// overwritten by the new lexicon. Lexicon operations have eventual
    /// consistency, therefore, it might take some time before the lexicon is
    /// available to the SynthesizeSpeech operation.
    ///
    /// For more information, see [Managing
    /// Lexicons](https://docs.aws.amazon.com/polly/latest/dg/managing-lexicons.html).
    pub fn putLexicon(self: *Self, allocator: std.mem.Allocator, input: put_lexicon.PutLexiconInput, options: CallOptions) !put_lexicon.PutLexiconOutput {
        return put_lexicon.execute(self, allocator, input, options);
    }

    /// Allows the creation of an asynchronous synthesis task, by starting a
    /// new `SpeechSynthesisTask`. This operation requires all the
    /// standard information needed for speech synthesis, plus the name of an
    /// Amazon S3 bucket for the service to store the output of the synthesis task
    /// and two optional parameters (`OutputS3KeyPrefix` and
    /// `SnsTopicArn`). Once the synthesis task is created, this
    /// operation will return a `SpeechSynthesisTask` object, which
    /// will include an identifier of this task as well as the current status. The
    /// `SpeechSynthesisTask` object is available for 72 hours after
    /// starting the asynchronous synthesis task.
    pub fn startSpeechSynthesisTask(self: *Self, allocator: std.mem.Allocator, input: start_speech_synthesis_task.StartSpeechSynthesisTaskInput, options: CallOptions) !start_speech_synthesis_task.StartSpeechSynthesisTaskOutput {
        return start_speech_synthesis_task.execute(self, allocator, input, options);
    }

    /// Synthesizes UTF-8 input, plain text or SSML, to a stream of bytes.
    /// SSML input must be valid, well-formed SSML. Some alphabets might not be
    /// available with all the voices (for example, Cyrillic might not be read at
    /// all by English voices) unless phoneme mapping is used. For more
    /// information, see [How it
    /// Works](https://docs.aws.amazon.com/polly/latest/dg/how-text-to-speech-works.html).
    pub fn synthesizeSpeech(self: *Self, allocator: std.mem.Allocator, input: synthesize_speech.SynthesizeSpeechInput, options: CallOptions) !synthesize_speech.SynthesizeSpeechOutput {
        return synthesize_speech.execute(self, allocator, input, options);
    }

    pub fn listSpeechSynthesisTasksPaginator(self: *Self, params: list_speech_synthesis_tasks.ListSpeechSynthesisTasksInput) paginator.ListSpeechSynthesisTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
