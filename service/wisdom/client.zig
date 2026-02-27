const aws = @import("aws");
const std = @import("std");

const create_assistant = @import("create_assistant.zig");
const create_assistant_association = @import("create_assistant_association.zig");
const create_content = @import("create_content.zig");
const create_knowledge_base = @import("create_knowledge_base.zig");
const create_quick_response = @import("create_quick_response.zig");
const create_session = @import("create_session.zig");
const delete_assistant = @import("delete_assistant.zig");
const delete_assistant_association = @import("delete_assistant_association.zig");
const delete_content = @import("delete_content.zig");
const delete_import_job = @import("delete_import_job.zig");
const delete_knowledge_base = @import("delete_knowledge_base.zig");
const delete_quick_response = @import("delete_quick_response.zig");
const get_assistant = @import("get_assistant.zig");
const get_assistant_association = @import("get_assistant_association.zig");
const get_content = @import("get_content.zig");
const get_content_summary = @import("get_content_summary.zig");
const get_import_job = @import("get_import_job.zig");
const get_knowledge_base = @import("get_knowledge_base.zig");
const get_quick_response = @import("get_quick_response.zig");
const get_recommendations = @import("get_recommendations.zig");
const get_session = @import("get_session.zig");
const list_assistant_associations = @import("list_assistant_associations.zig");
const list_assistants = @import("list_assistants.zig");
const list_contents = @import("list_contents.zig");
const list_import_jobs = @import("list_import_jobs.zig");
const list_knowledge_bases = @import("list_knowledge_bases.zig");
const list_quick_responses = @import("list_quick_responses.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const notify_recommendations_received = @import("notify_recommendations_received.zig");
const query_assistant = @import("query_assistant.zig");
const remove_knowledge_base_template_uri = @import("remove_knowledge_base_template_uri.zig");
const search_content = @import("search_content.zig");
const search_quick_responses = @import("search_quick_responses.zig");
const search_sessions = @import("search_sessions.zig");
const start_content_upload = @import("start_content_upload.zig");
const start_import_job = @import("start_import_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_content = @import("update_content.zig");
const update_knowledge_base_template_uri = @import("update_knowledge_base_template_uri.zig");
const update_quick_response = @import("update_quick_response.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Wisdom";

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

    /// Creates an Amazon Connect Wisdom assistant.
    pub fn createAssistant(self: *Self, allocator: std.mem.Allocator, input: create_assistant.CreateAssistantInput, options: create_assistant.Options) !create_assistant.CreateAssistantOutput {
        return create_assistant.execute(self, allocator, input, options);
    }

    /// Creates an association between an Amazon Connect Wisdom assistant and
    /// another resource. Currently, the
    /// only supported association is with a knowledge base. An assistant can have
    /// only a single
    /// association.
    pub fn createAssistantAssociation(self: *Self, allocator: std.mem.Allocator, input: create_assistant_association.CreateAssistantAssociationInput, options: create_assistant_association.Options) !create_assistant_association.CreateAssistantAssociationOutput {
        return create_assistant_association.execute(self, allocator, input, options);
    }

    /// Creates Wisdom content. Before to calling this API, use
    /// [StartContentUpload](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_StartContentUpload.html) to
    /// upload an asset.
    pub fn createContent(self: *Self, allocator: std.mem.Allocator, input: create_content.CreateContentInput, options: create_content.Options) !create_content.CreateContentOutput {
        return create_content.execute(self, allocator, input, options);
    }

    /// Creates a knowledge base.
    ///
    /// When using this API, you cannot reuse [Amazon
    /// AppIntegrations](https://docs.aws.amazon.com/appintegrations/latest/APIReference/Welcome.html)
    /// DataIntegrations with external knowledge bases such as Salesforce and
    /// ServiceNow. If you do,
    /// you'll get an `InvalidRequestException` error.
    ///
    /// For example, you're programmatically managing your external knowledge base,
    /// and you want
    /// to add or remove one of the fields that is being ingested from Salesforce.
    /// Do the
    /// following:
    ///
    /// * Call
    ///   [DeleteKnowledgeBase](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_DeleteKnowledgeBase.html).
    ///
    /// * Call
    ///   [DeleteDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_DeleteDataIntegration.html).
    ///
    /// * Call
    ///   [CreateDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_CreateDataIntegration.html) to recreate the DataIntegration or a create different
    /// one.
    ///
    /// * Call CreateKnowledgeBase.
    pub fn createKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: create_knowledge_base.CreateKnowledgeBaseInput, options: create_knowledge_base.Options) !create_knowledge_base.CreateKnowledgeBaseOutput {
        return create_knowledge_base.execute(self, allocator, input, options);
    }

    /// Creates a Wisdom quick response.
    pub fn createQuickResponse(self: *Self, allocator: std.mem.Allocator, input: create_quick_response.CreateQuickResponseInput, options: create_quick_response.Options) !create_quick_response.CreateQuickResponseOutput {
        return create_quick_response.execute(self, allocator, input, options);
    }

    /// Creates a session. A session is a contextual container used for generating
    /// recommendations. Amazon Connect creates a new Wisdom session for each
    /// contact on which
    /// Wisdom is enabled.
    pub fn createSession(self: *Self, allocator: std.mem.Allocator, input: create_session.CreateSessionInput, options: create_session.Options) !create_session.CreateSessionOutput {
        return create_session.execute(self, allocator, input, options);
    }

    /// Deletes an assistant.
    pub fn deleteAssistant(self: *Self, allocator: std.mem.Allocator, input: delete_assistant.DeleteAssistantInput, options: delete_assistant.Options) !delete_assistant.DeleteAssistantOutput {
        return delete_assistant.execute(self, allocator, input, options);
    }

    /// Deletes an assistant association.
    pub fn deleteAssistantAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_assistant_association.DeleteAssistantAssociationInput, options: delete_assistant_association.Options) !delete_assistant_association.DeleteAssistantAssociationOutput {
        return delete_assistant_association.execute(self, allocator, input, options);
    }

    /// Deletes the content.
    pub fn deleteContent(self: *Self, allocator: std.mem.Allocator, input: delete_content.DeleteContentInput, options: delete_content.Options) !delete_content.DeleteContentOutput {
        return delete_content.execute(self, allocator, input, options);
    }

    /// Deletes the quick response import job.
    pub fn deleteImportJob(self: *Self, allocator: std.mem.Allocator, input: delete_import_job.DeleteImportJobInput, options: delete_import_job.Options) !delete_import_job.DeleteImportJobOutput {
        return delete_import_job.execute(self, allocator, input, options);
    }

    /// Deletes the knowledge base.
    ///
    /// When you use this API to delete an external knowledge base such as
    /// Salesforce or
    /// ServiceNow, you must also delete the [Amazon
    /// AppIntegrations](https://docs.aws.amazon.com/appintegrations/latest/APIReference/Welcome.html)
    /// DataIntegration. This is because you can't reuse the DataIntegration after
    /// it's been
    /// associated with an external knowledge base. However, you can delete and
    /// recreate it. See
    /// [DeleteDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_DeleteDataIntegration.html) and [CreateDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_CreateDataIntegration.html) in the *Amazon AppIntegrations API
    /// Reference*.
    pub fn deleteKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: delete_knowledge_base.DeleteKnowledgeBaseInput, options: delete_knowledge_base.Options) !delete_knowledge_base.DeleteKnowledgeBaseOutput {
        return delete_knowledge_base.execute(self, allocator, input, options);
    }

    /// Deletes a quick response.
    pub fn deleteQuickResponse(self: *Self, allocator: std.mem.Allocator, input: delete_quick_response.DeleteQuickResponseInput, options: delete_quick_response.Options) !delete_quick_response.DeleteQuickResponseOutput {
        return delete_quick_response.execute(self, allocator, input, options);
    }

    /// Retrieves information about an assistant.
    pub fn getAssistant(self: *Self, allocator: std.mem.Allocator, input: get_assistant.GetAssistantInput, options: get_assistant.Options) !get_assistant.GetAssistantOutput {
        return get_assistant.execute(self, allocator, input, options);
    }

    /// Retrieves information about an assistant association.
    pub fn getAssistantAssociation(self: *Self, allocator: std.mem.Allocator, input: get_assistant_association.GetAssistantAssociationInput, options: get_assistant_association.Options) !get_assistant_association.GetAssistantAssociationOutput {
        return get_assistant_association.execute(self, allocator, input, options);
    }

    /// Retrieves content, including a pre-signed URL to download the content.
    pub fn getContent(self: *Self, allocator: std.mem.Allocator, input: get_content.GetContentInput, options: get_content.Options) !get_content.GetContentOutput {
        return get_content.execute(self, allocator, input, options);
    }

    /// Retrieves summary information about the content.
    pub fn getContentSummary(self: *Self, allocator: std.mem.Allocator, input: get_content_summary.GetContentSummaryInput, options: get_content_summary.Options) !get_content_summary.GetContentSummaryOutput {
        return get_content_summary.execute(self, allocator, input, options);
    }

    /// Retrieves the started import job.
    pub fn getImportJob(self: *Self, allocator: std.mem.Allocator, input: get_import_job.GetImportJobInput, options: get_import_job.Options) !get_import_job.GetImportJobOutput {
        return get_import_job.execute(self, allocator, input, options);
    }

    /// Retrieves information about the knowledge base.
    pub fn getKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: get_knowledge_base.GetKnowledgeBaseInput, options: get_knowledge_base.Options) !get_knowledge_base.GetKnowledgeBaseOutput {
        return get_knowledge_base.execute(self, allocator, input, options);
    }

    /// Retrieves the quick response.
    pub fn getQuickResponse(self: *Self, allocator: std.mem.Allocator, input: get_quick_response.GetQuickResponseInput, options: get_quick_response.Options) !get_quick_response.GetQuickResponseOutput {
        return get_quick_response.execute(self, allocator, input, options);
    }

    /// Retrieves recommendations for the specified session. To avoid retrieving the
    /// same
    /// recommendations in subsequent calls, use
    /// [NotifyRecommendationsReceived](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_NotifyRecommendationsReceived.html). This API supports long-polling behavior with the
    /// `waitTimeSeconds` parameter. Short poll is the default behavior and only
    /// returns
    /// recommendations already available. To perform a manual query against an
    /// assistant, use
    /// [QueryAssistant](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_QueryAssistant.html).
    pub fn getRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_recommendations.GetRecommendationsInput, options: get_recommendations.Options) !get_recommendations.GetRecommendationsOutput {
        return get_recommendations.execute(self, allocator, input, options);
    }

    /// Retrieves information for a specified session.
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: get_session.Options) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// Lists information about assistant associations.
    pub fn listAssistantAssociations(self: *Self, allocator: std.mem.Allocator, input: list_assistant_associations.ListAssistantAssociationsInput, options: list_assistant_associations.Options) !list_assistant_associations.ListAssistantAssociationsOutput {
        return list_assistant_associations.execute(self, allocator, input, options);
    }

    /// Lists information about assistants.
    pub fn listAssistants(self: *Self, allocator: std.mem.Allocator, input: list_assistants.ListAssistantsInput, options: list_assistants.Options) !list_assistants.ListAssistantsOutput {
        return list_assistants.execute(self, allocator, input, options);
    }

    /// Lists the content.
    pub fn listContents(self: *Self, allocator: std.mem.Allocator, input: list_contents.ListContentsInput, options: list_contents.Options) !list_contents.ListContentsOutput {
        return list_contents.execute(self, allocator, input, options);
    }

    /// Lists information about import jobs.
    pub fn listImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_import_jobs.ListImportJobsInput, options: list_import_jobs.Options) !list_import_jobs.ListImportJobsOutput {
        return list_import_jobs.execute(self, allocator, input, options);
    }

    /// Lists the knowledge bases.
    pub fn listKnowledgeBases(self: *Self, allocator: std.mem.Allocator, input: list_knowledge_bases.ListKnowledgeBasesInput, options: list_knowledge_bases.Options) !list_knowledge_bases.ListKnowledgeBasesOutput {
        return list_knowledge_bases.execute(self, allocator, input, options);
    }

    /// Lists information about quick response.
    pub fn listQuickResponses(self: *Self, allocator: std.mem.Allocator, input: list_quick_responses.ListQuickResponsesInput, options: list_quick_responses.Options) !list_quick_responses.ListQuickResponsesOutput {
        return list_quick_responses.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified recommendations from the specified assistant's queue
    /// of newly
    /// available recommendations. You can use this API in conjunction with
    /// [GetRecommendations](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_GetRecommendations.html) and a `waitTimeSeconds` input for long-polling
    /// behavior and avoiding duplicate recommendations.
    pub fn notifyRecommendationsReceived(self: *Self, allocator: std.mem.Allocator, input: notify_recommendations_received.NotifyRecommendationsReceivedInput, options: notify_recommendations_received.Options) !notify_recommendations_received.NotifyRecommendationsReceivedOutput {
        return notify_recommendations_received.execute(self, allocator, input, options);
    }

    /// Performs a manual search against the specified assistant. To retrieve
    /// recommendations for
    /// an assistant, use
    /// [GetRecommendations](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_GetRecommendations.html).
    pub fn queryAssistant(self: *Self, allocator: std.mem.Allocator, input: query_assistant.QueryAssistantInput, options: query_assistant.Options) !query_assistant.QueryAssistantOutput {
        return query_assistant.execute(self, allocator, input, options);
    }

    /// Removes a URI template from a knowledge base.
    pub fn removeKnowledgeBaseTemplateUri(self: *Self, allocator: std.mem.Allocator, input: remove_knowledge_base_template_uri.RemoveKnowledgeBaseTemplateUriInput, options: remove_knowledge_base_template_uri.Options) !remove_knowledge_base_template_uri.RemoveKnowledgeBaseTemplateUriOutput {
        return remove_knowledge_base_template_uri.execute(self, allocator, input, options);
    }

    /// Searches for content in a specified knowledge base. Can be used to get a
    /// specific content
    /// resource by its name.
    pub fn searchContent(self: *Self, allocator: std.mem.Allocator, input: search_content.SearchContentInput, options: search_content.Options) !search_content.SearchContentOutput {
        return search_content.execute(self, allocator, input, options);
    }

    /// Searches existing Wisdom quick responses in a Wisdom knowledge base.
    pub fn searchQuickResponses(self: *Self, allocator: std.mem.Allocator, input: search_quick_responses.SearchQuickResponsesInput, options: search_quick_responses.Options) !search_quick_responses.SearchQuickResponsesOutput {
        return search_quick_responses.execute(self, allocator, input, options);
    }

    /// Searches for sessions.
    pub fn searchSessions(self: *Self, allocator: std.mem.Allocator, input: search_sessions.SearchSessionsInput, options: search_sessions.Options) !search_sessions.SearchSessionsOutput {
        return search_sessions.execute(self, allocator, input, options);
    }

    /// Get a URL to upload content to a knowledge base. To upload content, first
    /// make a PUT
    /// request to the returned URL with your file, making sure to include the
    /// required headers. Then
    /// use
    /// [CreateContent](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_CreateContent.html) to finalize the content creation process or [UpdateContent](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_UpdateContent.html) to modify an existing resource. You can only upload content to a
    /// knowledge base of type CUSTOM.
    pub fn startContentUpload(self: *Self, allocator: std.mem.Allocator, input: start_content_upload.StartContentUploadInput, options: start_content_upload.Options) !start_content_upload.StartContentUploadOutput {
        return start_content_upload.execute(self, allocator, input, options);
    }

    /// Start an asynchronous job to import Wisdom resources from an uploaded source
    /// file. Before calling this API, use
    /// [StartContentUpload](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_StartContentUpload.html) to
    /// upload an asset that contains the resource data.
    ///
    /// * For importing Wisdom quick responses, you need to upload a csv file
    ///   including the quick responses. For information about how to format the csv
    ///   file for importing quick responses, see [Import quick
    ///   responses](https://docs.aws.amazon.com/console/connect/quick-responses/add-data).
    pub fn startImportJob(self: *Self, allocator: std.mem.Allocator, input: start_import_job.StartImportJobInput, options: start_import_job.Options) !start_import_job.StartImportJobOutput {
        return start_import_job.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates information about the content.
    pub fn updateContent(self: *Self, allocator: std.mem.Allocator, input: update_content.UpdateContentInput, options: update_content.Options) !update_content.UpdateContentOutput {
        return update_content.execute(self, allocator, input, options);
    }

    /// Updates the template URI of a knowledge base. This is only supported for
    /// knowledge bases
    /// of type EXTERNAL. Include a single variable in `${variable}` format; this
    /// interpolated by Wisdom using ingested content. For example, if you ingest a
    /// Salesforce
    /// article, it has an `Id` value, and you can set the template URI to
    /// `https://myInstanceName.lightning.force.com/lightning/r/Knowledge__kav/*${Id}*/view`.
    pub fn updateKnowledgeBaseTemplateUri(self: *Self, allocator: std.mem.Allocator, input: update_knowledge_base_template_uri.UpdateKnowledgeBaseTemplateUriInput, options: update_knowledge_base_template_uri.Options) !update_knowledge_base_template_uri.UpdateKnowledgeBaseTemplateUriOutput {
        return update_knowledge_base_template_uri.execute(self, allocator, input, options);
    }

    /// Updates an existing Wisdom quick response.
    pub fn updateQuickResponse(self: *Self, allocator: std.mem.Allocator, input: update_quick_response.UpdateQuickResponseInput, options: update_quick_response.Options) !update_quick_response.UpdateQuickResponseOutput {
        return update_quick_response.execute(self, allocator, input, options);
    }

    pub fn listAssistantAssociationsPaginator(self: *Self, params: list_assistant_associations.ListAssistantAssociationsInput) paginator.ListAssistantAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssistantsPaginator(self: *Self, params: list_assistants.ListAssistantsInput) paginator.ListAssistantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContentsPaginator(self: *Self, params: list_contents.ListContentsInput) paginator.ListContentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImportJobsPaginator(self: *Self, params: list_import_jobs.ListImportJobsInput) paginator.ListImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listKnowledgeBasesPaginator(self: *Self, params: list_knowledge_bases.ListKnowledgeBasesInput) paginator.ListKnowledgeBasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQuickResponsesPaginator(self: *Self, params: list_quick_responses.ListQuickResponsesInput) paginator.ListQuickResponsesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn queryAssistantPaginator(self: *Self, params: query_assistant.QueryAssistantInput) paginator.QueryAssistantPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchContentPaginator(self: *Self, params: search_content.SearchContentInput) paginator.SearchContentPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchQuickResponsesPaginator(self: *Self, params: search_quick_responses.SearchQuickResponsesInput) paginator.SearchQuickResponsesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchSessionsPaginator(self: *Self, params: search_sessions.SearchSessionsInput) paginator.SearchSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
