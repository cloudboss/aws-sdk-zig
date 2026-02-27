const aws = @import("aws");
const std = @import("std");

const create_call_analytics_category = @import("create_call_analytics_category.zig");
const create_language_model = @import("create_language_model.zig");
const create_medical_vocabulary = @import("create_medical_vocabulary.zig");
const create_vocabulary = @import("create_vocabulary.zig");
const create_vocabulary_filter = @import("create_vocabulary_filter.zig");
const delete_call_analytics_category = @import("delete_call_analytics_category.zig");
const delete_call_analytics_job = @import("delete_call_analytics_job.zig");
const delete_language_model = @import("delete_language_model.zig");
const delete_medical_scribe_job = @import("delete_medical_scribe_job.zig");
const delete_medical_transcription_job = @import("delete_medical_transcription_job.zig");
const delete_medical_vocabulary = @import("delete_medical_vocabulary.zig");
const delete_transcription_job = @import("delete_transcription_job.zig");
const delete_vocabulary = @import("delete_vocabulary.zig");
const delete_vocabulary_filter = @import("delete_vocabulary_filter.zig");
const describe_language_model = @import("describe_language_model.zig");
const get_call_analytics_category = @import("get_call_analytics_category.zig");
const get_call_analytics_job = @import("get_call_analytics_job.zig");
const get_medical_scribe_job = @import("get_medical_scribe_job.zig");
const get_medical_transcription_job = @import("get_medical_transcription_job.zig");
const get_medical_vocabulary = @import("get_medical_vocabulary.zig");
const get_transcription_job = @import("get_transcription_job.zig");
const get_vocabulary = @import("get_vocabulary.zig");
const get_vocabulary_filter = @import("get_vocabulary_filter.zig");
const list_call_analytics_categories = @import("list_call_analytics_categories.zig");
const list_call_analytics_jobs = @import("list_call_analytics_jobs.zig");
const list_language_models = @import("list_language_models.zig");
const list_medical_scribe_jobs = @import("list_medical_scribe_jobs.zig");
const list_medical_transcription_jobs = @import("list_medical_transcription_jobs.zig");
const list_medical_vocabularies = @import("list_medical_vocabularies.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_transcription_jobs = @import("list_transcription_jobs.zig");
const list_vocabularies = @import("list_vocabularies.zig");
const list_vocabulary_filters = @import("list_vocabulary_filters.zig");
const start_call_analytics_job = @import("start_call_analytics_job.zig");
const start_medical_scribe_job = @import("start_medical_scribe_job.zig");
const start_medical_transcription_job = @import("start_medical_transcription_job.zig");
const start_transcription_job = @import("start_transcription_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_call_analytics_category = @import("update_call_analytics_category.zig");
const update_medical_vocabulary = @import("update_medical_vocabulary.zig");
const update_vocabulary = @import("update_vocabulary.zig");
const update_vocabulary_filter = @import("update_vocabulary_filter.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Transcribe";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a new Call Analytics category.
    ///
    /// All categories are automatically applied to your Call Analytics
    /// transcriptions. Note that in
    /// order to apply categories to your transcriptions, you must create them
    /// before submitting your
    /// transcription request, as categories cannot be applied retroactively.
    ///
    /// When creating a new category, you can use the `InputType` parameter to
    /// label the category as a `POST_CALL` or a `REAL_TIME` category.
    /// `POST_CALL` categories can only be applied to post-call transcriptions and
    /// `REAL_TIME` categories can only be applied to real-time transcriptions. If
    /// you
    /// do not include `InputType`, your category is created as a
    /// `POST_CALL` category by default.
    ///
    /// Call Analytics categories are composed of rules. For each category, you must
    /// create
    /// between 1 and 20 rules. Rules can include these parameters: , , , and .
    ///
    /// To update an existing category, see .
    ///
    /// To learn more about Call Analytics categories, see [Creating categories for
    /// post-call
    /// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-batch.html) and [Creating categories for
    /// real-time
    /// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-stream.html).
    pub fn createCallAnalyticsCategory(self: *Self, allocator: std.mem.Allocator, input: create_call_analytics_category.CreateCallAnalyticsCategoryInput, options: create_call_analytics_category.Options) !create_call_analytics_category.CreateCallAnalyticsCategoryOutput {
        return create_call_analytics_category.execute(self, allocator, input, options);
    }

    /// Creates a new custom language model.
    ///
    /// When creating a new custom language model, you must specify:
    ///
    /// * If you want a Wideband (audio sample rates over 16,000 Hz) or Narrowband
    /// (audio sample rates under 16,000 Hz) base model
    ///
    /// * The location of your training and tuning files (this must be an Amazon S3
    ///   URI)
    ///
    /// * The language of your model
    ///
    /// * A unique name for your model
    pub fn createLanguageModel(self: *Self, allocator: std.mem.Allocator, input: create_language_model.CreateLanguageModelInput, options: create_language_model.Options) !create_language_model.CreateLanguageModelOutput {
        return create_language_model.execute(self, allocator, input, options);
    }

    /// Creates a new custom medical vocabulary.
    ///
    /// Before creating a new custom medical vocabulary, you must first upload a
    /// text file
    /// that contains your vocabulary table into an Amazon S3 bucket.
    /// Note that this differs from , where you can
    /// include a list of terms within your request using the `Phrases` flag;
    /// `CreateMedicalVocabulary` does not support the `Phrases`
    /// flag and only accepts vocabularies in table format.
    ///
    /// Each language has a character set that contains all allowed characters for
    /// that
    /// specific language. If you use unsupported characters, your custom vocabulary
    /// request
    /// fails. Refer to [Character Sets for Custom
    /// Vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/charsets.html) to get the character set for your
    /// language.
    ///
    /// For more information, see [Custom
    /// vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/custom-vocabulary.html).
    pub fn createMedicalVocabulary(self: *Self, allocator: std.mem.Allocator, input: create_medical_vocabulary.CreateMedicalVocabularyInput, options: create_medical_vocabulary.Options) !create_medical_vocabulary.CreateMedicalVocabularyOutput {
        return create_medical_vocabulary.execute(self, allocator, input, options);
    }

    /// Creates a new custom vocabulary.
    ///
    /// When creating a new custom vocabulary, you can either upload a text file
    /// that contains
    /// your new entries, phrases, and terms into an Amazon S3 bucket and include
    /// the
    /// URI in your request. Or you can include a list of terms directly in your
    /// request using
    /// the `Phrases` flag.
    ///
    /// Each language has a character set that contains all allowed characters for
    /// that
    /// specific language. If you use unsupported characters, your custom vocabulary
    /// request
    /// fails. Refer to [Character Sets for Custom
    /// Vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/charsets.html) to get the character set for your
    /// language.
    ///
    /// For more information, see [Custom
    /// vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/custom-vocabulary.html).
    pub fn createVocabulary(self: *Self, allocator: std.mem.Allocator, input: create_vocabulary.CreateVocabularyInput, options: create_vocabulary.Options) !create_vocabulary.CreateVocabularyOutput {
        return create_vocabulary.execute(self, allocator, input, options);
    }

    /// Creates a new custom vocabulary filter.
    ///
    /// You can use custom vocabulary filters to mask, delete, or flag specific
    /// words from
    /// your transcript. Custom vocabulary filters are commonly used to mask
    /// profanity in
    /// transcripts.
    ///
    /// Each language has a character set that contains all allowed characters for
    /// that
    /// specific language. If you use unsupported characters, your custom vocabulary
    /// filter
    /// request fails. Refer to [Character Sets for Custom
    /// Vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/charsets.html) to get the character set for your language.
    ///
    /// For more information, see [Vocabulary
    /// filtering](https://docs.aws.amazon.com/transcribe/latest/dg/vocabulary-filtering.html).
    pub fn createVocabularyFilter(self: *Self, allocator: std.mem.Allocator, input: create_vocabulary_filter.CreateVocabularyFilterInput, options: create_vocabulary_filter.Options) !create_vocabulary_filter.CreateVocabularyFilterOutput {
        return create_vocabulary_filter.execute(self, allocator, input, options);
    }

    /// Deletes a Call Analytics category. To use this operation, specify the name
    /// of the
    /// category you want to delete using `CategoryName`. Category names are case
    /// sensitive.
    pub fn deleteCallAnalyticsCategory(self: *Self, allocator: std.mem.Allocator, input: delete_call_analytics_category.DeleteCallAnalyticsCategoryInput, options: delete_call_analytics_category.Options) !delete_call_analytics_category.DeleteCallAnalyticsCategoryOutput {
        return delete_call_analytics_category.execute(self, allocator, input, options);
    }

    /// Deletes a Call Analytics job. To use this operation, specify the name of the
    /// job you
    /// want to delete using `CallAnalyticsJobName`. Job names are case
    /// sensitive.
    pub fn deleteCallAnalyticsJob(self: *Self, allocator: std.mem.Allocator, input: delete_call_analytics_job.DeleteCallAnalyticsJobInput, options: delete_call_analytics_job.Options) !delete_call_analytics_job.DeleteCallAnalyticsJobOutput {
        return delete_call_analytics_job.execute(self, allocator, input, options);
    }

    /// Deletes a custom language model. To use this operation, specify the name of
    /// the
    /// language model you want to delete using `ModelName`. custom language model
    /// names are case sensitive.
    pub fn deleteLanguageModel(self: *Self, allocator: std.mem.Allocator, input: delete_language_model.DeleteLanguageModelInput, options: delete_language_model.Options) !delete_language_model.DeleteLanguageModelOutput {
        return delete_language_model.execute(self, allocator, input, options);
    }

    /// Deletes a Medical Scribe job. To use this operation, specify the name of the
    /// job you want to delete using `MedicalScribeJobName`. Job names are
    /// case sensitive.
    pub fn deleteMedicalScribeJob(self: *Self, allocator: std.mem.Allocator, input: delete_medical_scribe_job.DeleteMedicalScribeJobInput, options: delete_medical_scribe_job.Options) !delete_medical_scribe_job.DeleteMedicalScribeJobOutput {
        return delete_medical_scribe_job.execute(self, allocator, input, options);
    }

    /// Deletes a medical transcription job. To use this operation, specify the name
    /// of the
    /// job you want to delete using `MedicalTranscriptionJobName`. Job names are
    /// case sensitive.
    pub fn deleteMedicalTranscriptionJob(self: *Self, allocator: std.mem.Allocator, input: delete_medical_transcription_job.DeleteMedicalTranscriptionJobInput, options: delete_medical_transcription_job.Options) !delete_medical_transcription_job.DeleteMedicalTranscriptionJobOutput {
        return delete_medical_transcription_job.execute(self, allocator, input, options);
    }

    /// Deletes a custom medical vocabulary. To use this operation, specify the name
    /// of the
    /// custom vocabulary you want to delete using `VocabularyName`. Custom
    /// vocabulary names are case sensitive.
    pub fn deleteMedicalVocabulary(self: *Self, allocator: std.mem.Allocator, input: delete_medical_vocabulary.DeleteMedicalVocabularyInput, options: delete_medical_vocabulary.Options) !delete_medical_vocabulary.DeleteMedicalVocabularyOutput {
        return delete_medical_vocabulary.execute(self, allocator, input, options);
    }

    /// Deletes a transcription job. To use this operation, specify the name of the
    /// job you
    /// want to delete using `TranscriptionJobName`. Job names are case
    /// sensitive.
    pub fn deleteTranscriptionJob(self: *Self, allocator: std.mem.Allocator, input: delete_transcription_job.DeleteTranscriptionJobInput, options: delete_transcription_job.Options) !delete_transcription_job.DeleteTranscriptionJobOutput {
        return delete_transcription_job.execute(self, allocator, input, options);
    }

    /// Deletes a custom vocabulary. To use this operation, specify the name of the
    /// custom
    /// vocabulary you want to delete using `VocabularyName`. Custom vocabulary
    /// names
    /// are case sensitive.
    pub fn deleteVocabulary(self: *Self, allocator: std.mem.Allocator, input: delete_vocabulary.DeleteVocabularyInput, options: delete_vocabulary.Options) !delete_vocabulary.DeleteVocabularyOutput {
        return delete_vocabulary.execute(self, allocator, input, options);
    }

    /// Deletes a custom vocabulary filter. To use this operation, specify the name
    /// of the
    /// custom vocabulary filter you want to delete using `VocabularyFilterName`.
    /// Custom vocabulary filter names are case sensitive.
    pub fn deleteVocabularyFilter(self: *Self, allocator: std.mem.Allocator, input: delete_vocabulary_filter.DeleteVocabularyFilterInput, options: delete_vocabulary_filter.Options) !delete_vocabulary_filter.DeleteVocabularyFilterOutput {
        return delete_vocabulary_filter.execute(self, allocator, input, options);
    }

    /// Provides information about the specified custom language model.
    ///
    /// This operation also shows if the base language model that you used to create
    /// your
    /// custom language model has been updated. If Amazon Transcribe has updated the
    /// base
    /// model, you can create a new custom language model using the updated base
    /// model.
    ///
    /// If you tried to create a new custom language model and the request wasn't
    /// successful,
    /// you can use `DescribeLanguageModel` to help identify the reason for this
    /// failure.
    pub fn describeLanguageModel(self: *Self, allocator: std.mem.Allocator, input: describe_language_model.DescribeLanguageModelInput, options: describe_language_model.Options) !describe_language_model.DescribeLanguageModelOutput {
        return describe_language_model.execute(self, allocator, input, options);
    }

    /// Provides information about the specified Call Analytics category.
    ///
    /// To get a list of your Call Analytics categories, use the operation.
    pub fn getCallAnalyticsCategory(self: *Self, allocator: std.mem.Allocator, input: get_call_analytics_category.GetCallAnalyticsCategoryInput, options: get_call_analytics_category.Options) !get_call_analytics_category.GetCallAnalyticsCategoryOutput {
        return get_call_analytics_category.execute(self, allocator, input, options);
    }

    /// Provides information about the specified Call Analytics job.
    ///
    /// To view the job's status, refer to `CallAnalyticsJobStatus`. If the status
    /// is `COMPLETED`, the job is finished. You can find your completed transcript
    /// at the URI specified in `TranscriptFileUri`. If the status is
    /// `FAILED`, `FailureReason` provides details on why your
    /// transcription job failed.
    ///
    /// If you enabled personally identifiable information (PII) redaction, the
    /// redacted
    /// transcript appears at the location specified in
    /// `RedactedTranscriptFileUri`.
    ///
    /// If you chose to redact the audio in your media file, you can find your
    /// redacted media
    /// file at the location specified in `RedactedMediaFileUri`.
    ///
    /// To get a list of your Call Analytics jobs, use the operation.
    pub fn getCallAnalyticsJob(self: *Self, allocator: std.mem.Allocator, input: get_call_analytics_job.GetCallAnalyticsJobInput, options: get_call_analytics_job.Options) !get_call_analytics_job.GetCallAnalyticsJobOutput {
        return get_call_analytics_job.execute(self, allocator, input, options);
    }

    /// Provides information about the specified Medical Scribe job.
    ///
    /// To view the status of the specified medical transcription job, check the
    /// `MedicalScribeJobStatus` field. If the status is `COMPLETED`,
    /// the job is finished. You can find the results at the location specified in
    /// `MedicalScribeOutput`.
    /// If the status is `FAILED`, `FailureReason` provides details on why your
    /// Medical Scribe job
    /// failed.
    ///
    /// To get a list of your Medical Scribe jobs, use the operation.
    pub fn getMedicalScribeJob(self: *Self, allocator: std.mem.Allocator, input: get_medical_scribe_job.GetMedicalScribeJobInput, options: get_medical_scribe_job.Options) !get_medical_scribe_job.GetMedicalScribeJobOutput {
        return get_medical_scribe_job.execute(self, allocator, input, options);
    }

    /// Provides information about the specified medical transcription job.
    ///
    /// To view the status of the specified medical transcription job, check the
    /// `TranscriptionJobStatus` field. If the status is `COMPLETED`,
    /// the job is finished. You can find the results at the location specified in
    /// `TranscriptFileUri`. If the status is `FAILED`,
    /// `FailureReason` provides details on why your transcription job
    /// failed.
    ///
    /// To get a list of your medical transcription jobs, use the operation.
    pub fn getMedicalTranscriptionJob(self: *Self, allocator: std.mem.Allocator, input: get_medical_transcription_job.GetMedicalTranscriptionJobInput, options: get_medical_transcription_job.Options) !get_medical_transcription_job.GetMedicalTranscriptionJobOutput {
        return get_medical_transcription_job.execute(self, allocator, input, options);
    }

    /// Provides information about the specified custom medical vocabulary.
    ///
    /// To view the status of the specified custom medical vocabulary, check the
    /// `VocabularyState` field. If the status is `READY`, your custom
    /// vocabulary is available to use. If the status is `FAILED`,
    /// `FailureReason` provides details on why your vocabulary failed.
    ///
    /// To get a list of your custom medical vocabularies, use the operation.
    pub fn getMedicalVocabulary(self: *Self, allocator: std.mem.Allocator, input: get_medical_vocabulary.GetMedicalVocabularyInput, options: get_medical_vocabulary.Options) !get_medical_vocabulary.GetMedicalVocabularyOutput {
        return get_medical_vocabulary.execute(self, allocator, input, options);
    }

    /// Provides information about the specified transcription job.
    ///
    /// To view the status of the specified transcription job, check the
    /// `TranscriptionJobStatus` field. If the status is `COMPLETED`,
    /// the job is finished. You can find the results at the location specified in
    /// `TranscriptFileUri`. If the status is `FAILED`,
    /// `FailureReason` provides details on why your transcription job
    /// failed.
    ///
    /// If you enabled content redaction, the redacted transcript can be found at
    /// the location
    /// specified in `RedactedTranscriptFileUri`.
    ///
    /// To get a list of your transcription jobs, use the operation.
    pub fn getTranscriptionJob(self: *Self, allocator: std.mem.Allocator, input: get_transcription_job.GetTranscriptionJobInput, options: get_transcription_job.Options) !get_transcription_job.GetTranscriptionJobOutput {
        return get_transcription_job.execute(self, allocator, input, options);
    }

    /// Provides information about the specified custom vocabulary.
    ///
    /// To view the status of the specified custom vocabulary, check the
    /// `VocabularyState` field. If the status is `READY`, your custom
    /// vocabulary is available to use. If the status is `FAILED`,
    /// `FailureReason` provides details on why your custom vocabulary
    /// failed.
    ///
    /// To get a list of your custom vocabularies, use the operation.
    pub fn getVocabulary(self: *Self, allocator: std.mem.Allocator, input: get_vocabulary.GetVocabularyInput, options: get_vocabulary.Options) !get_vocabulary.GetVocabularyOutput {
        return get_vocabulary.execute(self, allocator, input, options);
    }

    /// Provides information about the specified custom vocabulary filter.
    ///
    /// To get a list of your custom vocabulary filters, use the operation.
    pub fn getVocabularyFilter(self: *Self, allocator: std.mem.Allocator, input: get_vocabulary_filter.GetVocabularyFilterInput, options: get_vocabulary_filter.Options) !get_vocabulary_filter.GetVocabularyFilterOutput {
        return get_vocabulary_filter.execute(self, allocator, input, options);
    }

    /// Provides a list of Call Analytics categories, including all rules that make
    /// up each
    /// category.
    ///
    /// To get detailed information about a specific Call Analytics category, use
    /// the operation.
    pub fn listCallAnalyticsCategories(self: *Self, allocator: std.mem.Allocator, input: list_call_analytics_categories.ListCallAnalyticsCategoriesInput, options: list_call_analytics_categories.Options) !list_call_analytics_categories.ListCallAnalyticsCategoriesOutput {
        return list_call_analytics_categories.execute(self, allocator, input, options);
    }

    /// Provides a list of Call Analytics jobs that match the specified criteria. If
    /// no
    /// criteria are specified, all Call Analytics jobs are returned.
    ///
    /// To get detailed information about a specific Call Analytics job, use the
    /// operation.
    pub fn listCallAnalyticsJobs(self: *Self, allocator: std.mem.Allocator, input: list_call_analytics_jobs.ListCallAnalyticsJobsInput, options: list_call_analytics_jobs.Options) !list_call_analytics_jobs.ListCallAnalyticsJobsOutput {
        return list_call_analytics_jobs.execute(self, allocator, input, options);
    }

    /// Provides a list of custom language models that match the specified criteria.
    /// If no
    /// criteria are specified, all custom language models are returned.
    ///
    /// To get detailed information about a specific custom language model, use the
    /// operation.
    pub fn listLanguageModels(self: *Self, allocator: std.mem.Allocator, input: list_language_models.ListLanguageModelsInput, options: list_language_models.Options) !list_language_models.ListLanguageModelsOutput {
        return list_language_models.execute(self, allocator, input, options);
    }

    /// Provides a list of Medical Scribe jobs that match the specified criteria. If
    /// no
    /// criteria are specified, all Medical Scribe jobs are returned.
    ///
    /// To get detailed information about a specific Medical Scribe job, use the
    /// operation.
    pub fn listMedicalScribeJobs(self: *Self, allocator: std.mem.Allocator, input: list_medical_scribe_jobs.ListMedicalScribeJobsInput, options: list_medical_scribe_jobs.Options) !list_medical_scribe_jobs.ListMedicalScribeJobsOutput {
        return list_medical_scribe_jobs.execute(self, allocator, input, options);
    }

    /// Provides a list of medical transcription jobs that match the specified
    /// criteria. If no
    /// criteria are specified, all medical transcription jobs are returned.
    ///
    /// To get detailed information about a specific medical transcription job, use
    /// the operation.
    pub fn listMedicalTranscriptionJobs(self: *Self, allocator: std.mem.Allocator, input: list_medical_transcription_jobs.ListMedicalTranscriptionJobsInput, options: list_medical_transcription_jobs.Options) !list_medical_transcription_jobs.ListMedicalTranscriptionJobsOutput {
        return list_medical_transcription_jobs.execute(self, allocator, input, options);
    }

    /// Provides a list of custom medical vocabularies that match the specified
    /// criteria. If
    /// no criteria are specified, all custom medical vocabularies are returned.
    ///
    /// To get detailed information about a specific custom medical vocabulary, use
    /// the operation.
    pub fn listMedicalVocabularies(self: *Self, allocator: std.mem.Allocator, input: list_medical_vocabularies.ListMedicalVocabulariesInput, options: list_medical_vocabularies.Options) !list_medical_vocabularies.ListMedicalVocabulariesOutput {
        return list_medical_vocabularies.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with the specified transcription job, vocabulary,
    /// model, or
    /// resource.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Provides a list of transcription jobs that match the specified criteria. If
    /// no
    /// criteria are specified, all transcription jobs are returned.
    ///
    /// To get detailed information about a specific transcription job, use the
    /// operation.
    pub fn listTranscriptionJobs(self: *Self, allocator: std.mem.Allocator, input: list_transcription_jobs.ListTranscriptionJobsInput, options: list_transcription_jobs.Options) !list_transcription_jobs.ListTranscriptionJobsOutput {
        return list_transcription_jobs.execute(self, allocator, input, options);
    }

    /// Provides a list of custom vocabularies that match the specified criteria. If
    /// no
    /// criteria are specified, all custom vocabularies are returned.
    ///
    /// To get detailed information about a specific custom vocabulary, use the
    /// operation.
    pub fn listVocabularies(self: *Self, allocator: std.mem.Allocator, input: list_vocabularies.ListVocabulariesInput, options: list_vocabularies.Options) !list_vocabularies.ListVocabulariesOutput {
        return list_vocabularies.execute(self, allocator, input, options);
    }

    /// Provides a list of custom vocabulary filters that match the specified
    /// criteria. If no
    /// criteria are specified, all custom vocabularies are returned.
    ///
    /// To get detailed information about a specific custom vocabulary filter, use
    /// the operation.
    pub fn listVocabularyFilters(self: *Self, allocator: std.mem.Allocator, input: list_vocabulary_filters.ListVocabularyFiltersInput, options: list_vocabulary_filters.Options) !list_vocabulary_filters.ListVocabularyFiltersOutput {
        return list_vocabulary_filters.execute(self, allocator, input, options);
    }

    /// Transcribes the audio from a customer service call and applies any
    /// additional Request
    /// Parameters you choose to include in your request.
    ///
    /// In addition to many standard transcription features, Call Analytics provides
    /// you with
    /// call characteristics, call summarization, speaker sentiment, and optional
    /// redaction of
    /// your text transcript and your audio file. You can also apply custom
    /// categories to flag
    /// specified conditions. To learn more about these features and insights, refer
    /// to [Analyzing call
    /// center audio with Call
    /// Analytics](https://docs.aws.amazon.com/transcribe/latest/dg/call-analytics.html).
    ///
    /// If you want to apply categories to your Call Analytics job, you must create
    /// them
    /// before submitting your job request. Categories cannot be retroactively
    /// applied to a job.
    /// To create a new category, use the
    /// operation. To learn more about Call Analytics categories, see [Creating
    /// categories for post-call
    /// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-batch.html) and [Creating categories for
    /// real-time
    /// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-stream.html).
    ///
    /// To make a `StartCallAnalyticsJob` request, you must first upload your media
    /// file into an Amazon S3 bucket; you can then specify the Amazon S3
    /// location of the file using the `Media` parameter.
    ///
    /// Job queuing is available for Call Analytics jobs. If you pass a
    /// `DataAccessRoleArn`
    /// in your request and you exceed your Concurrent Job Limit, your job will
    /// automatically be
    /// added to a queue to be processed once your concurrent job count is below the
    /// limit.
    ///
    /// You must include the following parameters in your `StartCallAnalyticsJob`
    /// request:
    ///
    /// * `region`: The Amazon Web Services Region where you are making your
    /// request. For a list of Amazon Web Services Regions supported with Amazon
    /// Transcribe, refer to [Amazon Transcribe endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/transcribe.html).
    ///
    /// * `CallAnalyticsJobName`: A custom name that you create for your
    /// transcription job that's unique within your Amazon Web Services account.
    ///
    /// * `Media` (`MediaFileUri` or
    /// `RedactedMediaFileUri`): The Amazon S3 location of your
    /// media file.
    ///
    /// With Call Analytics, you can redact the audio contained in your media file
    /// by
    /// including `RedactedMediaFileUri`, instead of `MediaFileUri`,
    /// to specify the location of your input audio. If you choose to redact your
    /// audio, you
    /// can find your redacted media at the location specified in the
    /// `RedactedMediaFileUri` field of your response.
    pub fn startCallAnalyticsJob(self: *Self, allocator: std.mem.Allocator, input: start_call_analytics_job.StartCallAnalyticsJobInput, options: start_call_analytics_job.Options) !start_call_analytics_job.StartCallAnalyticsJobOutput {
        return start_call_analytics_job.execute(self, allocator, input, options);
    }

    /// Transcribes patient-clinician conversations and generates clinical notes.
    ///
    /// Amazon Web Services HealthScribe automatically provides rich conversation
    /// transcripts, identifies speaker roles,
    /// classifies dialogues, extracts medical terms, and generates preliminary
    /// clinical notes.
    /// To learn more about these features, refer to [Amazon Web Services
    /// HealthScribe](https://docs.aws.amazon.com/transcribe/latest/dg/health-scribe.html).
    ///
    /// To make a `StartMedicalScribeJob` request, you must first upload
    /// your media file into an Amazon S3 bucket; you can then specify the Amazon S3
    /// location
    /// of the file using the `Media` parameter.
    ///
    /// You must include the following parameters in your
    /// `StartMedicalTranscriptionJob` request:
    ///
    /// * `DataAccessRoleArn`: The ARN of an IAM role with the these minimum
    ///   permissions: read permission on input file Amazon S3 bucket specified in
    ///   `Media`,
    /// write permission on the Amazon S3 bucket specified in `OutputBucketName`,
    /// and full permissions on the KMS key specified in `OutputEncryptionKMSKeyId`
    /// (if set).
    /// The role should also allow `transcribe.amazonaws.com` to assume it.
    ///
    /// * `Media` (`MediaFileUri`): The Amazon S3 location
    /// of your media file.
    ///
    /// * `MedicalScribeJobName`: A custom name you create for your
    /// MedicalScribe job that is unique within your Amazon Web Services account.
    ///
    /// * `OutputBucketName`: The Amazon S3 bucket where you want
    /// your output files stored.
    ///
    /// * `Settings`: A `MedicalScribeSettings` object
    /// that must set exactly one of `ShowSpeakerLabels` or `ChannelIdentification`
    /// to true.
    /// If `ShowSpeakerLabels` is true, `MaxSpeakerLabels` must also be set.
    ///
    /// * `ChannelDefinitions`: A `MedicalScribeChannelDefinitions` array should be
    ///   set if and only if the `ChannelIdentification`
    /// value of `Settings` is set to true.
    pub fn startMedicalScribeJob(self: *Self, allocator: std.mem.Allocator, input: start_medical_scribe_job.StartMedicalScribeJobInput, options: start_medical_scribe_job.Options) !start_medical_scribe_job.StartMedicalScribeJobOutput {
        return start_medical_scribe_job.execute(self, allocator, input, options);
    }

    /// Transcribes the audio from a medical dictation or conversation and applies
    /// any
    /// additional Request Parameters you choose to include in your request.
    ///
    /// In addition to many standard transcription features, Amazon Transcribe
    /// Medical
    /// provides you with a robust medical vocabulary and, optionally, content
    /// identification,
    /// which adds flags to personal health information (PHI). To learn more about
    /// these
    /// features, refer to [How Amazon Transcribe Medical
    /// works](https://docs.aws.amazon.com/transcribe/latest/dg/how-it-works-med.html).
    ///
    /// To make a `StartMedicalTranscriptionJob` request, you must first upload
    /// your media file into an Amazon S3 bucket; you can then specify the Amazon S3
    /// location
    /// of the file using the `Media` parameter.
    ///
    /// You must include the following parameters in your
    /// `StartMedicalTranscriptionJob` request:
    ///
    /// * `region`: The Amazon Web Services Region where you are making your
    /// request. For a list of Amazon Web Services Regions supported with Amazon
    /// Transcribe, refer to [Amazon Transcribe endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/transcribe.html).
    ///
    /// * `MedicalTranscriptionJobName`: A custom name you create for your
    /// transcription job that is unique within your Amazon Web Services account.
    ///
    /// * `Media` (`MediaFileUri`): The Amazon S3 location
    /// of your media file.
    ///
    /// * `LanguageCode`: This must be `en-US`.
    ///
    /// * `OutputBucketName`: The Amazon S3 bucket where you want
    /// your transcript stored. If you want your output stored in a sub-folder of
    /// this
    /// bucket, you must also include `OutputKey`.
    ///
    /// * `Specialty`: This must be `PRIMARYCARE`.
    ///
    /// * `Type`: Choose whether your audio is a conversation or a
    /// dictation.
    pub fn startMedicalTranscriptionJob(self: *Self, allocator: std.mem.Allocator, input: start_medical_transcription_job.StartMedicalTranscriptionJobInput, options: start_medical_transcription_job.Options) !start_medical_transcription_job.StartMedicalTranscriptionJobOutput {
        return start_medical_transcription_job.execute(self, allocator, input, options);
    }

    /// Transcribes the audio from a media file and applies any additional Request
    /// Parameters
    /// you choose to include in your request.
    ///
    /// To make a `StartTranscriptionJob` request, you must first upload your media
    /// file into an Amazon S3 bucket; you can then specify the Amazon S3
    /// location of the file using the `Media` parameter.
    ///
    /// You must include the following parameters in your `StartTranscriptionJob`
    /// request:
    ///
    /// * `region`: The Amazon Web Services Region where you are making your
    /// request. For a list of Amazon Web Services Regions supported with Amazon
    /// Transcribe, refer to [Amazon Transcribe endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/transcribe.html).
    ///
    /// * `TranscriptionJobName`: A custom name you create for your
    /// transcription job that is unique within your Amazon Web Services account.
    ///
    /// * `Media` (`MediaFileUri`): The Amazon S3 location
    /// of your media file.
    ///
    /// * One of `LanguageCode`, `IdentifyLanguage`, or
    /// `IdentifyMultipleLanguages`: If you know the language of your
    /// media file, specify it using the `LanguageCode` parameter; you can
    /// find all valid language codes in the [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table. If you do not know the languages spoken in your
    /// media, use either `IdentifyLanguage` or
    /// `IdentifyMultipleLanguages` and let Amazon Transcribe identify
    /// the languages for you.
    pub fn startTranscriptionJob(self: *Self, allocator: std.mem.Allocator, input: start_transcription_job.StartTranscriptionJobInput, options: start_transcription_job.Options) !start_transcription_job.StartTranscriptionJobOutput {
        return start_transcription_job.execute(self, allocator, input, options);
    }

    /// Adds one or more custom tags, each in the form of a key:value pair, to the
    /// specified
    /// resource.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified Amazon Transcribe resource.
    ///
    /// If you include `UntagResource` in your request, you must also include
    /// `ResourceArn` and `TagKeys`.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified Call Analytics category with new rules. Note that the
    /// `UpdateCallAnalyticsCategory` operation overwrites all existing rules
    /// contained in the specified category. You cannot append additional rules onto
    /// an existing
    /// category.
    ///
    /// To create a new category, see .
    pub fn updateCallAnalyticsCategory(self: *Self, allocator: std.mem.Allocator, input: update_call_analytics_category.UpdateCallAnalyticsCategoryInput, options: update_call_analytics_category.Options) !update_call_analytics_category.UpdateCallAnalyticsCategoryOutput {
        return update_call_analytics_category.execute(self, allocator, input, options);
    }

    /// Updates an existing custom medical vocabulary with new values. This
    /// operation
    /// overwrites all existing information with your new values; you cannot append
    /// new terms
    /// onto an existing custom vocabulary.
    pub fn updateMedicalVocabulary(self: *Self, allocator: std.mem.Allocator, input: update_medical_vocabulary.UpdateMedicalVocabularyInput, options: update_medical_vocabulary.Options) !update_medical_vocabulary.UpdateMedicalVocabularyOutput {
        return update_medical_vocabulary.execute(self, allocator, input, options);
    }

    /// Updates an existing custom vocabulary with new values. This operation
    /// overwrites all
    /// existing information with your new values; you cannot append new terms onto
    /// an existing
    /// custom vocabulary.
    pub fn updateVocabulary(self: *Self, allocator: std.mem.Allocator, input: update_vocabulary.UpdateVocabularyInput, options: update_vocabulary.Options) !update_vocabulary.UpdateVocabularyOutput {
        return update_vocabulary.execute(self, allocator, input, options);
    }

    /// Updates an existing custom vocabulary filter with a new list of words. The
    /// new list
    /// you provide overwrites all previous entries; you cannot append new terms
    /// onto an
    /// existing custom vocabulary filter.
    pub fn updateVocabularyFilter(self: *Self, allocator: std.mem.Allocator, input: update_vocabulary_filter.UpdateVocabularyFilterInput, options: update_vocabulary_filter.Options) !update_vocabulary_filter.UpdateVocabularyFilterOutput {
        return update_vocabulary_filter.execute(self, allocator, input, options);
    }

    pub fn listCallAnalyticsCategoriesPaginator(self: *Self, params: list_call_analytics_categories.ListCallAnalyticsCategoriesInput) paginator.ListCallAnalyticsCategoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCallAnalyticsJobsPaginator(self: *Self, params: list_call_analytics_jobs.ListCallAnalyticsJobsInput) paginator.ListCallAnalyticsJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLanguageModelsPaginator(self: *Self, params: list_language_models.ListLanguageModelsInput) paginator.ListLanguageModelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMedicalScribeJobsPaginator(self: *Self, params: list_medical_scribe_jobs.ListMedicalScribeJobsInput) paginator.ListMedicalScribeJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMedicalTranscriptionJobsPaginator(self: *Self, params: list_medical_transcription_jobs.ListMedicalTranscriptionJobsInput) paginator.ListMedicalTranscriptionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMedicalVocabulariesPaginator(self: *Self, params: list_medical_vocabularies.ListMedicalVocabulariesInput) paginator.ListMedicalVocabulariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTranscriptionJobsPaginator(self: *Self, params: list_transcription_jobs.ListTranscriptionJobsInput) paginator.ListTranscriptionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVocabulariesPaginator(self: *Self, params: list_vocabularies.ListVocabulariesInput) paginator.ListVocabulariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVocabularyFiltersPaginator(self: *Self, params: list_vocabulary_filters.ListVocabularyFiltersInput) paginator.ListVocabularyFiltersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilCallAnalyticsJobCompleted(self: *Self, params: get_call_analytics_job.GetCallAnalyticsJobInput) aws.waiter.WaiterError!void {
        var w = waiters.CallAnalyticsJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilLanguageModelCompleted(self: *Self, params: describe_language_model.DescribeLanguageModelInput) aws.waiter.WaiterError!void {
        var w = waiters.LanguageModelCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilMedicalScribeJobCompleted(self: *Self, params: get_medical_scribe_job.GetMedicalScribeJobInput) aws.waiter.WaiterError!void {
        var w = waiters.MedicalScribeJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilMedicalTranscriptionJobCompleted(self: *Self, params: get_medical_transcription_job.GetMedicalTranscriptionJobInput) aws.waiter.WaiterError!void {
        var w = waiters.MedicalTranscriptionJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilMedicalVocabularyReady(self: *Self, params: get_medical_vocabulary.GetMedicalVocabularyInput) aws.waiter.WaiterError!void {
        var w = waiters.MedicalVocabularyReadyWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilTranscriptionJobCompleted(self: *Self, params: get_transcription_job.GetTranscriptionJobInput) aws.waiter.WaiterError!void {
        var w = waiters.TranscriptionJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilVocabularyReady(self: *Self, params: get_vocabulary.GetVocabularyInput) aws.waiter.WaiterError!void {
        var w = waiters.VocabularyReadyWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
