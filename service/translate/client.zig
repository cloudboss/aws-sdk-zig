const aws = @import("aws");
const std = @import("std");

const create_parallel_data = @import("create_parallel_data.zig");
const delete_parallel_data = @import("delete_parallel_data.zig");
const delete_terminology = @import("delete_terminology.zig");
const describe_text_translation_job = @import("describe_text_translation_job.zig");
const get_parallel_data = @import("get_parallel_data.zig");
const get_terminology = @import("get_terminology.zig");
const import_terminology = @import("import_terminology.zig");
const list_languages = @import("list_languages.zig");
const list_parallel_data = @import("list_parallel_data.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_terminologies = @import("list_terminologies.zig");
const list_text_translation_jobs = @import("list_text_translation_jobs.zig");
const start_text_translation_job = @import("start_text_translation_job.zig");
const stop_text_translation_job = @import("stop_text_translation_job.zig");
const tag_resource = @import("tag_resource.zig");
const translate_document = @import("translate_document.zig");
const translate_text = @import("translate_text.zig");
const untag_resource = @import("untag_resource.zig");
const update_parallel_data = @import("update_parallel_data.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Translate";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a parallel data resource in Amazon Translate by importing an input
    /// file from
    /// Amazon S3. Parallel data files contain examples that show how you want
    /// segments of text to be
    /// translated. By adding parallel data, you can influence the style, tone, and
    /// word choice in
    /// your translation output.
    pub fn createParallelData(self: *Self, allocator: std.mem.Allocator, input: create_parallel_data.CreateParallelDataInput, options: create_parallel_data.Options) !create_parallel_data.CreateParallelDataOutput {
        return create_parallel_data.execute(self, allocator, input, options);
    }

    /// Deletes a parallel data resource in Amazon Translate.
    pub fn deleteParallelData(self: *Self, allocator: std.mem.Allocator, input: delete_parallel_data.DeleteParallelDataInput, options: delete_parallel_data.Options) !delete_parallel_data.DeleteParallelDataOutput {
        return delete_parallel_data.execute(self, allocator, input, options);
    }

    /// A synchronous action that deletes a custom terminology.
    pub fn deleteTerminology(self: *Self, allocator: std.mem.Allocator, input: delete_terminology.DeleteTerminologyInput, options: delete_terminology.Options) !delete_terminology.DeleteTerminologyOutput {
        return delete_terminology.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with an asynchronous batch translation job
    /// including name,
    /// ID, status, source and target languages, input/output S3 buckets, and so on.
    pub fn describeTextTranslationJob(self: *Self, allocator: std.mem.Allocator, input: describe_text_translation_job.DescribeTextTranslationJobInput, options: describe_text_translation_job.Options) !describe_text_translation_job.DescribeTextTranslationJobOutput {
        return describe_text_translation_job.execute(self, allocator, input, options);
    }

    /// Provides information about a parallel data resource.
    pub fn getParallelData(self: *Self, allocator: std.mem.Allocator, input: get_parallel_data.GetParallelDataInput, options: get_parallel_data.Options) !get_parallel_data.GetParallelDataOutput {
        return get_parallel_data.execute(self, allocator, input, options);
    }

    /// Retrieves a custom terminology.
    pub fn getTerminology(self: *Self, allocator: std.mem.Allocator, input: get_terminology.GetTerminologyInput, options: get_terminology.Options) !get_terminology.GetTerminologyOutput {
        return get_terminology.execute(self, allocator, input, options);
    }

    /// Creates or updates a custom terminology, depending on whether one already
    /// exists for the
    /// given terminology name. Importing a terminology with the same name as an
    /// existing one will
    /// merge the terminologies based on the chosen merge strategy. The only
    /// supported merge strategy
    /// is OVERWRITE, where the imported terminology overwrites the existing
    /// terminology of the same
    /// name.
    ///
    /// If you import a terminology that overwrites an existing one, the new
    /// terminology takes up
    /// to 10 minutes to fully propagate. After that, translations have access to
    /// the new
    /// terminology.
    pub fn importTerminology(self: *Self, allocator: std.mem.Allocator, input: import_terminology.ImportTerminologyInput, options: import_terminology.Options) !import_terminology.ImportTerminologyOutput {
        return import_terminology.execute(self, allocator, input, options);
    }

    /// Provides a list of languages (RFC-5646 codes and names) that Amazon
    /// Translate supports.
    pub fn listLanguages(self: *Self, allocator: std.mem.Allocator, input: list_languages.ListLanguagesInput, options: list_languages.Options) !list_languages.ListLanguagesOutput {
        return list_languages.execute(self, allocator, input, options);
    }

    /// Provides a list of your parallel data resources in Amazon Translate.
    pub fn listParallelData(self: *Self, allocator: std.mem.Allocator, input: list_parallel_data.ListParallelDataInput, options: list_parallel_data.Options) !list_parallel_data.ListParallelDataOutput {
        return list_parallel_data.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with a given Amazon Translate resource.
    /// For more information, see [
    /// Tagging your
    /// resources](https://docs.aws.amazon.com/translate/latest/dg/tagging.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Provides a list of custom terminologies associated with your account.
    pub fn listTerminologies(self: *Self, allocator: std.mem.Allocator, input: list_terminologies.ListTerminologiesInput, options: list_terminologies.Options) !list_terminologies.ListTerminologiesOutput {
        return list_terminologies.execute(self, allocator, input, options);
    }

    /// Gets a list of the batch translation jobs that you have submitted.
    pub fn listTextTranslationJobs(self: *Self, allocator: std.mem.Allocator, input: list_text_translation_jobs.ListTextTranslationJobsInput, options: list_text_translation_jobs.Options) !list_text_translation_jobs.ListTextTranslationJobsOutput {
        return list_text_translation_jobs.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous batch translation job. Use batch translation jobs to
    /// translate large volumes of text across multiple documents at once.
    /// For batch translation, you can input documents with different source
    /// languages (specify `auto`
    /// as the source language). You can specify one
    /// or more target languages. Batch translation translates each input document
    /// into each of the target languages.
    /// For more information, see
    /// [Asynchronous batch
    /// processing](https://docs.aws.amazon.com/translate/latest/dg/async.html).
    ///
    /// Batch translation jobs can be described with the DescribeTextTranslationJob
    /// operation, listed with the ListTextTranslationJobs operation, and stopped
    /// with the StopTextTranslationJob operation.
    pub fn startTextTranslationJob(self: *Self, allocator: std.mem.Allocator, input: start_text_translation_job.StartTextTranslationJobInput, options: start_text_translation_job.Options) !start_text_translation_job.StartTextTranslationJobOutput {
        return start_text_translation_job.execute(self, allocator, input, options);
    }

    /// Stops an asynchronous batch translation job that is in progress.
    ///
    /// If the job's state is `IN_PROGRESS`, the job will be marked for termination
    /// and
    /// put into the `STOP_REQUESTED` state. If the job completes before it can be
    /// stopped,
    /// it is put into the `COMPLETED` state. Otherwise, the job is put into the
    /// `STOPPED` state.
    ///
    /// Asynchronous batch translation jobs are started with the
    /// StartTextTranslationJob operation. You can use the
    /// DescribeTextTranslationJob or ListTextTranslationJobs
    /// operations to get a batch translation job's `JobId`.
    pub fn stopTextTranslationJob(self: *Self, allocator: std.mem.Allocator, input: stop_text_translation_job.StopTextTranslationJobInput, options: stop_text_translation_job.Options) !stop_text_translation_job.StopTextTranslationJobOutput {
        return stop_text_translation_job.execute(self, allocator, input, options);
    }

    /// Associates a specific tag with a resource. A tag is a key-value pair
    /// that adds as a metadata to a resource.
    /// For more information, see [
    /// Tagging your
    /// resources](https://docs.aws.amazon.com/translate/latest/dg/tagging.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Translates the input document from the source language to the target
    /// language.
    /// This synchronous operation supports text, HTML, or Word documents as the
    /// input document.
    ///
    /// `TranslateDocument` supports translations from English to any supported
    /// language,
    /// and from any supported language to English. Therefore, specify either the
    /// source language code
    /// or the target language code as “en” (English).
    ///
    /// If you set the `Formality` parameter, the request will fail if the target
    /// language does
    /// not support formality. For a list of target languages that support
    /// formality, see
    /// [Setting
    /// formality](https://docs.aws.amazon.com/translate/latest/dg/customizing-translations-formality.html).
    pub fn translateDocument(self: *Self, allocator: std.mem.Allocator, input: translate_document.TranslateDocumentInput, options: translate_document.Options) !translate_document.TranslateDocumentOutput {
        return translate_document.execute(self, allocator, input, options);
    }

    /// Translates input text from the source language to the target language. For a
    /// list of
    /// available languages and language codes, see [Supported
    /// languages](https://docs.aws.amazon.com/translate/latest/dg/what-is-languages.html).
    pub fn translateText(self: *Self, allocator: std.mem.Allocator, input: translate_text.TranslateTextInput, options: translate_text.Options) !translate_text.TranslateTextOutput {
        return translate_text.execute(self, allocator, input, options);
    }

    /// Removes a specific tag associated with an Amazon Translate resource.
    /// For more information, see [
    /// Tagging your
    /// resources](https://docs.aws.amazon.com/translate/latest/dg/tagging.html).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a previously created parallel data resource by importing a new input
    /// file from
    /// Amazon S3.
    pub fn updateParallelData(self: *Self, allocator: std.mem.Allocator, input: update_parallel_data.UpdateParallelDataInput, options: update_parallel_data.Options) !update_parallel_data.UpdateParallelDataOutput {
        return update_parallel_data.execute(self, allocator, input, options);
    }

    pub fn listLanguagesPaginator(self: *Self, params: list_languages.ListLanguagesInput) paginator.ListLanguagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listParallelDataPaginator(self: *Self, params: list_parallel_data.ListParallelDataInput) paginator.ListParallelDataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTerminologiesPaginator(self: *Self, params: list_terminologies.ListTerminologiesInput) paginator.ListTerminologiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTextTranslationJobsPaginator(self: *Self, params: list_text_translation_jobs.ListTextTranslationJobsInput) paginator.ListTextTranslationJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
