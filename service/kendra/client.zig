const aws = @import("aws");
const std = @import("std");

const associate_entities_to_experience = @import("associate_entities_to_experience.zig");
const associate_personas_to_entities = @import("associate_personas_to_entities.zig");
const batch_delete_document = @import("batch_delete_document.zig");
const batch_delete_featured_results_set = @import("batch_delete_featured_results_set.zig");
const batch_get_document_status = @import("batch_get_document_status.zig");
const batch_put_document = @import("batch_put_document.zig");
const clear_query_suggestions = @import("clear_query_suggestions.zig");
const create_access_control_configuration = @import("create_access_control_configuration.zig");
const create_data_source = @import("create_data_source.zig");
const create_experience = @import("create_experience.zig");
const create_faq = @import("create_faq.zig");
const create_featured_results_set = @import("create_featured_results_set.zig");
const create_index = @import("create_index.zig");
const create_query_suggestions_block_list = @import("create_query_suggestions_block_list.zig");
const create_thesaurus = @import("create_thesaurus.zig");
const delete_access_control_configuration = @import("delete_access_control_configuration.zig");
const delete_data_source = @import("delete_data_source.zig");
const delete_experience = @import("delete_experience.zig");
const delete_faq = @import("delete_faq.zig");
const delete_index = @import("delete_index.zig");
const delete_principal_mapping = @import("delete_principal_mapping.zig");
const delete_query_suggestions_block_list = @import("delete_query_suggestions_block_list.zig");
const delete_thesaurus = @import("delete_thesaurus.zig");
const describe_access_control_configuration = @import("describe_access_control_configuration.zig");
const describe_data_source = @import("describe_data_source.zig");
const describe_experience = @import("describe_experience.zig");
const describe_faq = @import("describe_faq.zig");
const describe_featured_results_set = @import("describe_featured_results_set.zig");
const describe_index = @import("describe_index.zig");
const describe_principal_mapping = @import("describe_principal_mapping.zig");
const describe_query_suggestions_block_list = @import("describe_query_suggestions_block_list.zig");
const describe_query_suggestions_config = @import("describe_query_suggestions_config.zig");
const describe_thesaurus = @import("describe_thesaurus.zig");
const disassociate_entities_from_experience = @import("disassociate_entities_from_experience.zig");
const disassociate_personas_from_entities = @import("disassociate_personas_from_entities.zig");
const get_query_suggestions = @import("get_query_suggestions.zig");
const get_snapshots = @import("get_snapshots.zig");
const list_access_control_configurations = @import("list_access_control_configurations.zig");
const list_data_source_sync_jobs = @import("list_data_source_sync_jobs.zig");
const list_data_sources = @import("list_data_sources.zig");
const list_entity_personas = @import("list_entity_personas.zig");
const list_experience_entities = @import("list_experience_entities.zig");
const list_experiences = @import("list_experiences.zig");
const list_faqs = @import("list_faqs.zig");
const list_featured_results_sets = @import("list_featured_results_sets.zig");
const list_groups_older_than_ordering_id = @import("list_groups_older_than_ordering_id.zig");
const list_indices = @import("list_indices.zig");
const list_query_suggestions_block_lists = @import("list_query_suggestions_block_lists.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_thesauri = @import("list_thesauri.zig");
const put_principal_mapping = @import("put_principal_mapping.zig");
const query_ = @import("query.zig");
const retrieve_ = @import("retrieve.zig");
const start_data_source_sync_job = @import("start_data_source_sync_job.zig");
const stop_data_source_sync_job = @import("stop_data_source_sync_job.zig");
const submit_feedback = @import("submit_feedback.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_access_control_configuration = @import("update_access_control_configuration.zig");
const update_data_source = @import("update_data_source.zig");
const update_experience = @import("update_experience.zig");
const update_featured_results_set = @import("update_featured_results_set.zig");
const update_index = @import("update_index.zig");
const update_query_suggestions_block_list = @import("update_query_suggestions_block_list.zig");
const update_query_suggestions_config = @import("update_query_suggestions_config.zig");
const update_thesaurus = @import("update_thesaurus.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "kendra";

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

    /// Grants users or groups in your IAM Identity Center identity source access
    /// to your Amazon Kendra experience. You can create an Amazon Kendra experience
    /// such as a
    /// search application. For more information on creating a search application
    /// experience, see [Building
    /// a search experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn associateEntitiesToExperience(self: *Self, allocator: std.mem.Allocator, input: associate_entities_to_experience.AssociateEntitiesToExperienceInput, options: associate_entities_to_experience.Options) !associate_entities_to_experience.AssociateEntitiesToExperienceOutput {
        return associate_entities_to_experience.execute(self, allocator, input, options);
    }

    /// Defines the specific permissions of users or groups in your IAM Identity
    /// Center
    /// identity source with access to your Amazon Kendra experience. You can create
    /// an Amazon Kendra
    /// experience such as a search application. For more information on creating a
    /// search application experience, see [Building
    /// a search experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn associatePersonasToEntities(self: *Self, allocator: std.mem.Allocator, input: associate_personas_to_entities.AssociatePersonasToEntitiesInput, options: associate_personas_to_entities.Options) !associate_personas_to_entities.AssociatePersonasToEntitiesOutput {
        return associate_personas_to_entities.execute(self, allocator, input, options);
    }

    /// Removes one or more documents from an index. The documents must have been
    /// added with
    /// the `BatchPutDocument` API.
    ///
    /// The documents are deleted asynchronously. You can see the progress of the
    /// deletion by
    /// using Amazon Web Services
    /// CloudWatch. Any error messages related to the processing of the batch are
    /// sent to
    /// your Amazon Web Services
    /// CloudWatch log. You can also use the `BatchGetDocumentStatus` API to
    /// monitor the progress of deleting your documents.
    ///
    /// Deleting documents from an index using `BatchDeleteDocument` could take up
    /// to an hour or more, depending on the number of documents you want to delete.
    pub fn batchDeleteDocument(self: *Self, allocator: std.mem.Allocator, input: batch_delete_document.BatchDeleteDocumentInput, options: batch_delete_document.Options) !batch_delete_document.BatchDeleteDocumentOutput {
        return batch_delete_document.execute(self, allocator, input, options);
    }

    /// Removes one or more sets of featured results. Features results are placed
    /// above all other results for certain queries. If there's an exact match of a
    /// query, then one or more specific documents are featured in the search
    /// results.
    pub fn batchDeleteFeaturedResultsSet(self: *Self, allocator: std.mem.Allocator, input: batch_delete_featured_results_set.BatchDeleteFeaturedResultsSetInput, options: batch_delete_featured_results_set.Options) !batch_delete_featured_results_set.BatchDeleteFeaturedResultsSetOutput {
        return batch_delete_featured_results_set.execute(self, allocator, input, options);
    }

    /// Returns the indexing status for one or more documents submitted with the [
    /// BatchPutDocument](https://docs.aws.amazon.com/kendra/latest/dg/API_BatchPutDocument.html) API.
    ///
    /// When you use the `BatchPutDocument` API, documents are indexed
    /// asynchronously. You can use the `BatchGetDocumentStatus` API to get the
    /// current status of a list of documents so that you can determine if they have
    /// been
    /// successfully indexed.
    ///
    /// You can also use the `BatchGetDocumentStatus` API to check the status of
    /// the [
    /// BatchDeleteDocument](https://docs.aws.amazon.com/kendra/latest/dg/API_BatchDeleteDocument.html) API. When a document is deleted from the index, Amazon Kendra returns `NOT_FOUND` as the status.
    pub fn batchGetDocumentStatus(self: *Self, allocator: std.mem.Allocator, input: batch_get_document_status.BatchGetDocumentStatusInput, options: batch_get_document_status.Options) !batch_get_document_status.BatchGetDocumentStatusOutput {
        return batch_get_document_status.execute(self, allocator, input, options);
    }

    /// Adds one or more documents to an index.
    ///
    /// The `BatchPutDocument` API enables you to ingest inline documents or a set
    /// of documents stored in an Amazon S3 bucket. Use this API to ingest your text
    /// and
    /// unstructured text into an index, add custom attributes to the documents, and
    /// to attach
    /// an access control list to the documents added to the index.
    ///
    /// The documents are indexed asynchronously. You can see the progress of the
    /// batch using
    /// Amazon Web Services
    /// CloudWatch. Any error messages related to processing the batch are sent to
    /// your
    /// Amazon Web Services
    /// CloudWatch log. You can also use the `BatchGetDocumentStatus` API to
    /// monitor the progress of indexing your documents.
    ///
    /// For an example of ingesting inline documents using Python and Java SDKs, see
    /// [Adding files
    /// directly to an
    /// index](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-binary-doc.html).
    pub fn batchPutDocument(self: *Self, allocator: std.mem.Allocator, input: batch_put_document.BatchPutDocumentInput, options: batch_put_document.Options) !batch_put_document.BatchPutDocumentOutput {
        return batch_put_document.execute(self, allocator, input, options);
    }

    /// Clears existing query suggestions from an index.
    ///
    /// This deletes existing suggestions only, not the queries
    /// in the query log. After you clear suggestions, Amazon Kendra learns
    /// new suggestions based on new queries added to the query log
    /// from the time you cleared suggestions. If you do not see any
    /// new suggestions, then please allow Amazon Kendra to collect
    /// enough queries to learn new suggestions.
    ///
    /// `ClearQuerySuggestions` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    pub fn clearQuerySuggestions(self: *Self, allocator: std.mem.Allocator, input: clear_query_suggestions.ClearQuerySuggestionsInput, options: clear_query_suggestions.Options) !clear_query_suggestions.ClearQuerySuggestionsOutput {
        return clear_query_suggestions.execute(self, allocator, input, options);
    }

    /// Creates an access configuration for your documents. This includes user and
    /// group
    /// access information for your documents. This is useful for user context
    /// filtering, where
    /// search results are filtered based on the user or their group access to
    /// documents.
    ///
    /// You can use this to re-configure your existing document level access control
    /// without
    /// indexing all of your documents again. For example, your index contains
    /// top-secret
    /// company documents that only certain employees or users should access. One of
    /// these users
    /// leaves the company or switches to a team that should be blocked from
    /// accessing
    /// top-secret documents. The user still has access to top-secret documents
    /// because the user
    /// had access when your documents were previously indexed. You can create a
    /// specific access
    /// control configuration for the user with deny access. You can later update
    /// the access
    /// control configuration to allow access if the user returns to the company and
    /// re-joins
    /// the 'top-secret' team. You can re-configure access control for your
    /// documents as
    /// circumstances change.
    ///
    /// To apply your access control configuration to certain documents, you call
    /// the
    /// [BatchPutDocument](https://docs.aws.amazon.com/kendra/latest/dg/API_BatchPutDocument.html) API with the `AccessControlConfigurationId`
    /// included in the
    /// [Document](https://docs.aws.amazon.com/kendra/latest/dg/API_Document.html)
    /// object. If you use an S3 bucket as a data source, you update the
    /// `.metadata.json` with the `AccessControlConfigurationId` and
    /// synchronize your data source. Amazon Kendra currently only supports access
    /// control
    /// configuration for S3 data sources and documents indexed using the
    /// `BatchPutDocument` API.
    ///
    /// You can't configure access control using
    /// `CreateAccessControlConfiguration` for an Amazon Kendra Gen AI Enterprise
    /// Edition index. Amazon Kendra will return a `ValidationException` error for a
    /// `Gen_AI_ENTERPRISE_EDITION` index.
    pub fn createAccessControlConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_access_control_configuration.CreateAccessControlConfigurationInput, options: create_access_control_configuration.Options) !create_access_control_configuration.CreateAccessControlConfigurationOutput {
        return create_access_control_configuration.execute(self, allocator, input, options);
    }

    /// Creates a data source connector that you want to use with an Amazon Kendra
    /// index.
    ///
    /// You specify a name, data source connector type and description for your data
    /// source. You
    /// also specify configuration information for the data source connector.
    ///
    /// `CreateDataSource` is a synchronous operation. The operation returns 200 if
    /// the
    /// data source was successfully created. Otherwise, an exception is raised.
    ///
    /// For an example of creating an index and data source using the Python SDK,
    /// see [Getting started with Python
    /// SDK](https://docs.aws.amazon.com/kendra/latest/dg/gs-python.html). For an
    /// example of creating an index and data source using the Java SDK, see
    /// [Getting started with Java
    /// SDK](https://docs.aws.amazon.com/kendra/latest/dg/gs-java.html).
    pub fn createDataSource(self: *Self, allocator: std.mem.Allocator, input: create_data_source.CreateDataSourceInput, options: create_data_source.Options) !create_data_source.CreateDataSourceOutput {
        return create_data_source.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Kendra experience such as a search application. For more
    /// information
    /// on creating a search application experience, including using the Python and
    /// Java SDKs,
    /// see [Building a
    /// search experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn createExperience(self: *Self, allocator: std.mem.Allocator, input: create_experience.CreateExperienceInput, options: create_experience.Options) !create_experience.CreateExperienceOutput {
        return create_experience.execute(self, allocator, input, options);
    }

    /// Creates a set of frequently ask questions (FAQs) using a specified FAQ file
    /// stored
    /// in an Amazon S3 bucket.
    ///
    /// Adding FAQs to an index is an asynchronous operation.
    ///
    /// For an example of adding an FAQ to an index using Python and Java SDKs, see
    /// [Using your FAQ
    /// file](https://docs.aws.amazon.com/kendra/latest/dg/in-creating-faq.html#using-faq-file).
    pub fn createFaq(self: *Self, allocator: std.mem.Allocator, input: create_faq.CreateFaqInput, options: create_faq.Options) !create_faq.CreateFaqOutput {
        return create_faq.execute(self, allocator, input, options);
    }

    /// Creates a set of featured results to display at the top of the search
    /// results page.
    /// Featured results are placed above all other results for certain queries. You
    /// map
    /// specific queries to specific documents for featuring in the results. If a
    /// query
    /// contains an exact match, then one or more specific documents are featured in
    /// the
    /// search results.
    ///
    /// You can create up to 50 sets of featured results per index. You can request
    /// to
    /// increase this limit by contacting
    /// [Support](http://aws.amazon.com/contact-us/).
    pub fn createFeaturedResultsSet(self: *Self, allocator: std.mem.Allocator, input: create_featured_results_set.CreateFeaturedResultsSetInput, options: create_featured_results_set.Options) !create_featured_results_set.CreateFeaturedResultsSetOutput {
        return create_featured_results_set.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Kendra index. Index creation is an asynchronous API. To
    /// determine
    /// if index creation has completed, check the `Status` field returned from a
    /// call to
    /// `DescribeIndex`. The `Status` field is set to `ACTIVE` when
    /// the index is ready to use.
    ///
    /// Once the index is active, you can index your documents using the
    /// `BatchPutDocument` API or using one of the supported [data
    /// sources](https://docs.aws.amazon.com/kendra/latest/dg/data-sources.html).
    ///
    /// For an example of creating an index and data source using the Python SDK,
    /// see [Getting started with Python
    /// SDK](https://docs.aws.amazon.com/kendra/latest/dg/gs-python.html). For an
    /// example of creating an index and data source using the Java SDK, see
    /// [Getting started with Java
    /// SDK](https://docs.aws.amazon.com/kendra/latest/dg/gs-java.html).
    pub fn createIndex(self: *Self, allocator: std.mem.Allocator, input: create_index.CreateIndexInput, options: create_index.Options) !create_index.CreateIndexOutput {
        return create_index.execute(self, allocator, input, options);
    }

    /// Creates a block list to exlcude certain queries from suggestions.
    ///
    /// Any query that contains words or phrases specified in the block
    /// list is blocked or filtered out from being shown as a suggestion.
    ///
    /// You need to provide the file location of your block list text file
    /// in your S3 bucket. In your text file, enter each block word or phrase
    /// on a separate line.
    ///
    /// For information on the current quota limits for block lists, see
    /// [Quotas
    /// for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/quotas.html).
    ///
    /// `CreateQuerySuggestionsBlockList` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    ///
    /// For an example of creating a block list for query suggestions using the
    /// Python SDK, see [Query
    /// suggestions block
    /// list](https://docs.aws.amazon.com/kendra/latest/dg/query-suggestions.html#query-suggestions-blocklist).
    pub fn createQuerySuggestionsBlockList(self: *Self, allocator: std.mem.Allocator, input: create_query_suggestions_block_list.CreateQuerySuggestionsBlockListInput, options: create_query_suggestions_block_list.Options) !create_query_suggestions_block_list.CreateQuerySuggestionsBlockListOutput {
        return create_query_suggestions_block_list.execute(self, allocator, input, options);
    }

    /// Creates a thesaurus for an index. The thesaurus
    /// contains a list of synonyms in Solr format.
    ///
    /// For an example of adding a thesaurus file to an index, see
    /// [Adding
    /// custom synonyms to an
    /// index](https://docs.aws.amazon.com/kendra/latest/dg/index-synonyms-adding-thesaurus-file.html).
    pub fn createThesaurus(self: *Self, allocator: std.mem.Allocator, input: create_thesaurus.CreateThesaurusInput, options: create_thesaurus.Options) !create_thesaurus.CreateThesaurusOutput {
        return create_thesaurus.execute(self, allocator, input, options);
    }

    /// Deletes an access control configuration that you created for your documents
    /// in an
    /// index. This includes user and group access information for your documents.
    /// This is
    /// useful for user context filtering, where search results are filtered based
    /// on the user
    /// or their group access to documents.
    pub fn deleteAccessControlConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_access_control_configuration.DeleteAccessControlConfigurationInput, options: delete_access_control_configuration.Options) !delete_access_control_configuration.DeleteAccessControlConfigurationOutput {
        return delete_access_control_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Kendra data source connector. An exception is not thrown
    /// if the
    /// data source is already being deleted. While the data source is being
    /// deleted, the
    /// `Status` field returned by a call to the `DescribeDataSource` API is
    /// set to `DELETING`. For more information, see [Deleting Data
    /// Sources](https://docs.aws.amazon.com/kendra/latest/dg/delete-data-source.html).
    ///
    /// Deleting an entire data source or re-syncing your index after deleting
    /// specific documents
    /// from a data source could take up to an hour or more, depending on the number
    /// of documents you
    /// want to delete.
    pub fn deleteDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_data_source.DeleteDataSourceInput, options: delete_data_source.Options) !delete_data_source.DeleteDataSourceOutput {
        return delete_data_source.execute(self, allocator, input, options);
    }

    /// Deletes your Amazon Kendra experience such as a search application. For more
    /// information on
    /// creating a search application experience, see [Building a search
    /// experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn deleteExperience(self: *Self, allocator: std.mem.Allocator, input: delete_experience.DeleteExperienceInput, options: delete_experience.Options) !delete_experience.DeleteExperienceOutput {
        return delete_experience.execute(self, allocator, input, options);
    }

    /// Removes a FAQ from an index.
    pub fn deleteFaq(self: *Self, allocator: std.mem.Allocator, input: delete_faq.DeleteFaqInput, options: delete_faq.Options) !delete_faq.DeleteFaqOutput {
        return delete_faq.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Kendra index. An exception is not thrown if the index is
    /// already
    /// being deleted. While the index is being deleted, the `Status` field returned
    /// by a
    /// call to the `DescribeIndex` API is set to `DELETING`.
    pub fn deleteIndex(self: *Self, allocator: std.mem.Allocator, input: delete_index.DeleteIndexInput, options: delete_index.Options) !delete_index.DeleteIndexOutput {
        return delete_index.execute(self, allocator, input, options);
    }

    /// Deletes a group so that all users that belong to the group can no
    /// longer access documents only available to that group.
    ///
    /// For example, after deleting the group "Summer Interns", all interns who
    /// belonged to
    /// that group no longer see intern-only documents in their search results.
    ///
    /// If you want to delete or replace users or sub groups of a group, you need to
    /// use the
    /// `PutPrincipalMapping` operation. For example, if a user in the group
    /// "Engineering" leaves the engineering team and another user takes their
    /// place, you
    /// provide an updated list of users or sub groups that belong to the
    /// "Engineering" group
    /// when calling `PutPrincipalMapping`. You can update your internal list of
    /// users or sub groups and input this list when calling
    /// `PutPrincipalMapping`.
    ///
    /// `DeletePrincipalMapping` is currently not supported in the Amazon Web
    /// Services GovCloud (US-West) region.
    pub fn deletePrincipalMapping(self: *Self, allocator: std.mem.Allocator, input: delete_principal_mapping.DeletePrincipalMappingInput, options: delete_principal_mapping.Options) !delete_principal_mapping.DeletePrincipalMappingOutput {
        return delete_principal_mapping.execute(self, allocator, input, options);
    }

    /// Deletes a block list used for query suggestions for an index.
    ///
    /// A deleted block list might not take effect right away. Amazon Kendra
    /// needs to refresh the entire suggestions list to add back the
    /// queries that were previously blocked.
    ///
    /// `DeleteQuerySuggestionsBlockList` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    pub fn deleteQuerySuggestionsBlockList(self: *Self, allocator: std.mem.Allocator, input: delete_query_suggestions_block_list.DeleteQuerySuggestionsBlockListInput, options: delete_query_suggestions_block_list.Options) !delete_query_suggestions_block_list.DeleteQuerySuggestionsBlockListOutput {
        return delete_query_suggestions_block_list.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Kendra thesaurus.
    pub fn deleteThesaurus(self: *Self, allocator: std.mem.Allocator, input: delete_thesaurus.DeleteThesaurusInput, options: delete_thesaurus.Options) !delete_thesaurus.DeleteThesaurusOutput {
        return delete_thesaurus.execute(self, allocator, input, options);
    }

    /// Gets information about an access control configuration that you created for
    /// your
    /// documents in an index. This includes user and group access information for
    /// your
    /// documents. This is useful for user context filtering, where search results
    /// are filtered
    /// based on the user or their group access to documents.
    pub fn describeAccessControlConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_access_control_configuration.DescribeAccessControlConfigurationInput, options: describe_access_control_configuration.Options) !describe_access_control_configuration.DescribeAccessControlConfigurationOutput {
        return describe_access_control_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about an Amazon Kendra data source connector.
    pub fn describeDataSource(self: *Self, allocator: std.mem.Allocator, input: describe_data_source.DescribeDataSourceInput, options: describe_data_source.Options) !describe_data_source.DescribeDataSourceOutput {
        return describe_data_source.execute(self, allocator, input, options);
    }

    /// Gets information about your Amazon Kendra experience such as a search
    /// application.
    /// For more information on creating a search application experience,
    /// see [Building
    /// a search experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn describeExperience(self: *Self, allocator: std.mem.Allocator, input: describe_experience.DescribeExperienceInput, options: describe_experience.Options) !describe_experience.DescribeExperienceOutput {
        return describe_experience.execute(self, allocator, input, options);
    }

    /// Gets information about a FAQ.
    pub fn describeFaq(self: *Self, allocator: std.mem.Allocator, input: describe_faq.DescribeFaqInput, options: describe_faq.Options) !describe_faq.DescribeFaqOutput {
        return describe_faq.execute(self, allocator, input, options);
    }

    /// Gets information about a set of featured results. Features results are
    /// placed
    /// above all other results for certain queries. If there's an exact match of a
    /// query,
    /// then one or more specific documents are featured in the search results.
    pub fn describeFeaturedResultsSet(self: *Self, allocator: std.mem.Allocator, input: describe_featured_results_set.DescribeFeaturedResultsSetInput, options: describe_featured_results_set.Options) !describe_featured_results_set.DescribeFeaturedResultsSetOutput {
        return describe_featured_results_set.execute(self, allocator, input, options);
    }

    /// Gets information about an Amazon Kendra index.
    pub fn describeIndex(self: *Self, allocator: std.mem.Allocator, input: describe_index.DescribeIndexInput, options: describe_index.Options) !describe_index.DescribeIndexOutput {
        return describe_index.execute(self, allocator, input, options);
    }

    /// Describes the processing of `PUT` and `DELETE` actions for
    /// mapping users to their groups. This includes information on the status of
    /// actions
    /// currently processing or yet to be processed, when actions were last updated,
    /// when
    /// actions were received by Amazon Kendra, the latest action that should
    /// process and
    /// apply after other actions, and useful error messages if an action could not
    /// be
    /// processed.
    ///
    /// `DescribePrincipalMapping` is currently not supported in the Amazon Web
    /// Services GovCloud (US-West) region.
    pub fn describePrincipalMapping(self: *Self, allocator: std.mem.Allocator, input: describe_principal_mapping.DescribePrincipalMappingInput, options: describe_principal_mapping.Options) !describe_principal_mapping.DescribePrincipalMappingOutput {
        return describe_principal_mapping.execute(self, allocator, input, options);
    }

    /// Gets information about a block list used for query suggestions for
    /// an index.
    ///
    /// This is used to check the current settings that are applied to a
    /// block list.
    ///
    /// `DescribeQuerySuggestionsBlockList` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    pub fn describeQuerySuggestionsBlockList(self: *Self, allocator: std.mem.Allocator, input: describe_query_suggestions_block_list.DescribeQuerySuggestionsBlockListInput, options: describe_query_suggestions_block_list.Options) !describe_query_suggestions_block_list.DescribeQuerySuggestionsBlockListOutput {
        return describe_query_suggestions_block_list.execute(self, allocator, input, options);
    }

    /// Gets information on the settings of query suggestions for an index.
    ///
    /// This is used to check the current settings applied
    /// to query suggestions.
    ///
    /// `DescribeQuerySuggestionsConfig` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    pub fn describeQuerySuggestionsConfig(self: *Self, allocator: std.mem.Allocator, input: describe_query_suggestions_config.DescribeQuerySuggestionsConfigInput, options: describe_query_suggestions_config.Options) !describe_query_suggestions_config.DescribeQuerySuggestionsConfigOutput {
        return describe_query_suggestions_config.execute(self, allocator, input, options);
    }

    /// Gets information about an Amazon Kendra thesaurus.
    pub fn describeThesaurus(self: *Self, allocator: std.mem.Allocator, input: describe_thesaurus.DescribeThesaurusInput, options: describe_thesaurus.Options) !describe_thesaurus.DescribeThesaurusOutput {
        return describe_thesaurus.execute(self, allocator, input, options);
    }

    /// Prevents users or groups in your IAM Identity Center identity source
    /// from accessing your Amazon Kendra experience. You can create an Amazon
    /// Kendra experience
    /// such as a search application. For more information on creating a search
    /// application experience, see [Building
    /// a search experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn disassociateEntitiesFromExperience(self: *Self, allocator: std.mem.Allocator, input: disassociate_entities_from_experience.DisassociateEntitiesFromExperienceInput, options: disassociate_entities_from_experience.Options) !disassociate_entities_from_experience.DisassociateEntitiesFromExperienceOutput {
        return disassociate_entities_from_experience.execute(self, allocator, input, options);
    }

    /// Removes the specific permissions of users or groups in your IAM Identity
    /// Center
    /// identity source with access to your Amazon Kendra experience. You can create
    /// an Amazon Kendra
    /// experience such as a search application. For more information on creating a
    /// search application experience, see [Building a
    /// search experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn disassociatePersonasFromEntities(self: *Self, allocator: std.mem.Allocator, input: disassociate_personas_from_entities.DisassociatePersonasFromEntitiesInput, options: disassociate_personas_from_entities.Options) !disassociate_personas_from_entities.DisassociatePersonasFromEntitiesOutput {
        return disassociate_personas_from_entities.execute(self, allocator, input, options);
    }

    /// Fetches the queries that are suggested to your users.
    ///
    /// `GetQuerySuggestions` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    pub fn getQuerySuggestions(self: *Self, allocator: std.mem.Allocator, input: get_query_suggestions.GetQuerySuggestionsInput, options: get_query_suggestions.Options) !get_query_suggestions.GetQuerySuggestionsOutput {
        return get_query_suggestions.execute(self, allocator, input, options);
    }

    /// Retrieves search metrics data. The data provides a snapshot of how your
    /// users interact
    /// with your search application and how effective the application is.
    pub fn getSnapshots(self: *Self, allocator: std.mem.Allocator, input: get_snapshots.GetSnapshotsInput, options: get_snapshots.Options) !get_snapshots.GetSnapshotsOutput {
        return get_snapshots.execute(self, allocator, input, options);
    }

    /// Lists one or more access control configurations for an index. This includes
    /// user and
    /// group access information for your documents. This is useful for user context
    /// filtering,
    /// where search results are filtered based on the user or their group access to
    /// documents.
    pub fn listAccessControlConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_access_control_configurations.ListAccessControlConfigurationsInput, options: list_access_control_configurations.Options) !list_access_control_configurations.ListAccessControlConfigurationsOutput {
        return list_access_control_configurations.execute(self, allocator, input, options);
    }

    /// Gets statistics about synchronizing a data source connector.
    pub fn listDataSourceSyncJobs(self: *Self, allocator: std.mem.Allocator, input: list_data_source_sync_jobs.ListDataSourceSyncJobsInput, options: list_data_source_sync_jobs.Options) !list_data_source_sync_jobs.ListDataSourceSyncJobsOutput {
        return list_data_source_sync_jobs.execute(self, allocator, input, options);
    }

    /// Lists the data source connectors that you have created.
    pub fn listDataSources(self: *Self, allocator: std.mem.Allocator, input: list_data_sources.ListDataSourcesInput, options: list_data_sources.Options) !list_data_sources.ListDataSourcesOutput {
        return list_data_sources.execute(self, allocator, input, options);
    }

    /// Lists specific permissions of users and groups with access to your
    /// Amazon Kendra experience.
    pub fn listEntityPersonas(self: *Self, allocator: std.mem.Allocator, input: list_entity_personas.ListEntityPersonasInput, options: list_entity_personas.Options) !list_entity_personas.ListEntityPersonasOutput {
        return list_entity_personas.execute(self, allocator, input, options);
    }

    /// Lists users or groups in your IAM Identity Center identity source that are
    /// granted access to your Amazon Kendra experience. You can create an Amazon
    /// Kendra experience
    /// such as a search application. For more information on creating a search
    /// application experience, see [Building
    /// a search experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn listExperienceEntities(self: *Self, allocator: std.mem.Allocator, input: list_experience_entities.ListExperienceEntitiesInput, options: list_experience_entities.Options) !list_experience_entities.ListExperienceEntitiesOutput {
        return list_experience_entities.execute(self, allocator, input, options);
    }

    /// Lists one or more Amazon Kendra experiences. You can create an Amazon Kendra
    /// experience such
    /// as a search application. For more information on creating a search
    /// application
    /// experience, see [Building a
    /// search experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn listExperiences(self: *Self, allocator: std.mem.Allocator, input: list_experiences.ListExperiencesInput, options: list_experiences.Options) !list_experiences.ListExperiencesOutput {
        return list_experiences.execute(self, allocator, input, options);
    }

    /// Gets a list of FAQs associated with an index.
    pub fn listFaqs(self: *Self, allocator: std.mem.Allocator, input: list_faqs.ListFaqsInput, options: list_faqs.Options) !list_faqs.ListFaqsOutput {
        return list_faqs.execute(self, allocator, input, options);
    }

    /// Lists all your sets of featured results for a given index. Features results
    /// are placed above all other results for certain queries. If there's an exact
    /// match
    /// of a query, then one or more specific documents are featured in the search
    /// results.
    pub fn listFeaturedResultsSets(self: *Self, allocator: std.mem.Allocator, input: list_featured_results_sets.ListFeaturedResultsSetsInput, options: list_featured_results_sets.Options) !list_featured_results_sets.ListFeaturedResultsSetsOutput {
        return list_featured_results_sets.execute(self, allocator, input, options);
    }

    /// Provides a list of groups that are mapped to users before a given ordering
    /// or
    /// timestamp identifier.
    ///
    /// `ListGroupsOlderThanOrderingId` is currently not supported in the Amazon Web
    /// Services GovCloud (US-West) region.
    pub fn listGroupsOlderThanOrderingId(self: *Self, allocator: std.mem.Allocator, input: list_groups_older_than_ordering_id.ListGroupsOlderThanOrderingIdInput, options: list_groups_older_than_ordering_id.Options) !list_groups_older_than_ordering_id.ListGroupsOlderThanOrderingIdOutput {
        return list_groups_older_than_ordering_id.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Kendra indexes that you created.
    pub fn listIndices(self: *Self, allocator: std.mem.Allocator, input: list_indices.ListIndicesInput, options: list_indices.Options) !list_indices.ListIndicesOutput {
        return list_indices.execute(self, allocator, input, options);
    }

    /// Lists the block lists used for query suggestions for an index.
    ///
    /// For information on the current quota limits for block lists, see
    /// [Quotas
    /// for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/quotas.html).
    ///
    /// `ListQuerySuggestionsBlockLists` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    pub fn listQuerySuggestionsBlockLists(self: *Self, allocator: std.mem.Allocator, input: list_query_suggestions_block_lists.ListQuerySuggestionsBlockListsInput, options: list_query_suggestions_block_lists.Options) !list_query_suggestions_block_lists.ListQuerySuggestionsBlockListsOutput {
        return list_query_suggestions_block_lists.execute(self, allocator, input, options);
    }

    /// Gets a list of tags associated with a resource. Indexes, FAQs, data sources,
    /// and
    /// other resources can have tags associated with them.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the thesauri for an index.
    pub fn listThesauri(self: *Self, allocator: std.mem.Allocator, input: list_thesauri.ListThesauriInput, options: list_thesauri.Options) !list_thesauri.ListThesauriOutput {
        return list_thesauri.execute(self, allocator, input, options);
    }

    /// Maps users to their groups so that you only need to provide the user ID when
    /// you issue
    /// the query.
    ///
    /// You can also map sub groups to groups. For example, the group "Company
    /// Intellectual
    /// Property Teams" includes sub groups "Research" and "Engineering". These sub
    /// groups
    /// include their own list of users or people who work in these teams. Only
    /// users who work
    /// in research and engineering, and therefore belong in the intellectual
    /// property group,
    /// can see top-secret company documents in their search results.
    ///
    /// This is useful for user context filtering, where search results are filtered
    /// based on
    /// the user or their group access to documents. For more information, see
    /// [Filtering on
    /// user
    /// context](https://docs.aws.amazon.com/kendra/latest/dg/user-context-filter.html).
    ///
    /// If more than five `PUT` actions for a group are currently processing, a
    /// validation exception is thrown.
    pub fn putPrincipalMapping(self: *Self, allocator: std.mem.Allocator, input: put_principal_mapping.PutPrincipalMappingInput, options: put_principal_mapping.Options) !put_principal_mapping.PutPrincipalMappingOutput {
        return put_principal_mapping.execute(self, allocator, input, options);
    }

    /// Searches an index given an input query.
    ///
    /// If you are working with large language models (LLMs) or implementing
    /// retrieval
    /// augmented generation (RAG) systems, you can use Amazon Kendra's
    /// [Retrieve](https://docs.aws.amazon.com/kendra/latest/APIReference/API_Retrieve.html) API, which can return longer semantically relevant passages. We
    /// recommend using the `Retrieve` API instead of filing a service limit
    /// increase
    /// to increase the `Query` API document excerpt length.
    ///
    /// You can configure boosting or relevance tuning at the query level to
    /// override boosting
    /// at the index level, filter based on document fields/attributes and faceted
    /// search, and
    /// filter based on the user or their group access to documents. You can also
    /// include certain
    /// fields in the response that might provide useful additional information.
    ///
    /// A query response contains three types of results.
    ///
    /// * Relevant suggested answers. The answers can be either a text excerpt or
    ///   table
    /// excerpt. The answer can be highlighted in the excerpt.
    ///
    /// * Matching FAQs or questions-answer from your FAQ file.
    ///
    /// * Relevant documents. This result type includes an excerpt of the document
    ///   with the
    /// document title. The searched terms can be highlighted in the excerpt.
    ///
    /// You can specify that the query return only one type of result using the
    /// `QueryResultTypeFilter` parameter. Each query returns the 100 most relevant
    /// results. If you filter result type to only question-answers, a maximum of
    /// four results are
    /// returned. If you filter result type to only answers, a maximum of three
    /// results are
    /// returned.
    ///
    /// If you're using an Amazon Kendra Gen AI Enterprise Edition index, you can
    /// only use
    /// `ATTRIBUTE_FILTER` to filter search results by user context. If you're
    /// using an Amazon Kendra Gen AI Enterprise Edition index and you try to use
    /// `USER_TOKEN` to configure user context policy, Amazon Kendra returns a
    /// `ValidationException` error.
    pub fn query(self: *Self, allocator: std.mem.Allocator, input: query_.QueryInput, options: query_.Options) !query_.QueryOutput {
        return query_.execute(self, allocator, input, options);
    }

    /// Retrieves relevant passages or text excerpts given an input query.
    ///
    /// This API is similar to the
    /// [Query](https://docs.aws.amazon.com/kendra/latest/APIReference/API_Query.html) API. However, by
    /// default, the `Query` API only returns excerpt passages of up to 100 token
    /// words. With the `Retrieve` API, you can retrieve longer passages of up to
    /// 200
    /// token words and up to 100 semantically relevant passages. This doesn't
    /// include
    /// question-answer or FAQ type responses from your index. The passages are text
    /// excerpts
    /// that can be semantically extracted from multiple documents and multiple
    /// parts of the
    /// same document. If in extreme cases your documents produce zero passages
    /// using the
    /// `Retrieve` API, you can alternatively use the `Query` API and
    /// its types of responses.
    ///
    /// You can also do the following:
    ///
    /// * Override boosting at the index level
    ///
    /// * Filter based on document fields or attributes
    ///
    /// * Filter based on the user or their group access to documents
    ///
    /// * View the confidence score bucket for a retrieved passage result. The
    /// confidence bucket provides a relative ranking that indicates how confident
    /// Amazon Kendra is that the response is relevant to the query.
    ///
    /// Confidence score buckets are currently available only for English.
    ///
    /// You can also include certain fields in the response that might provide
    /// useful
    /// additional information.
    ///
    /// The `Retrieve` API shares the number of [query capacity
    /// units](https://docs.aws.amazon.com/kendra/latest/APIReference/API_CapacityUnitsConfiguration.html) that you set for your index. For more information on what's included
    /// in a single capacity unit and the default base capacity for an index, see
    /// [Adjusting
    /// capacity](https://docs.aws.amazon.com/kendra/latest/dg/adjusting-capacity.html).
    ///
    /// If you're using an Amazon Kendra Gen AI Enterprise Edition index, you can
    /// only use
    /// `ATTRIBUTE_FILTER` to filter search results by user context. If
    /// you're using an Amazon Kendra Gen AI Enterprise Edition index and you try to
    /// use
    /// `USER_TOKEN` to configure user context policy, Amazon Kendra returns a
    /// `ValidationException` error.
    pub fn retrieve(self: *Self, allocator: std.mem.Allocator, input: retrieve_.RetrieveInput, options: retrieve_.Options) !retrieve_.RetrieveOutput {
        return retrieve_.execute(self, allocator, input, options);
    }

    /// Starts a synchronization job for a data source connector. If a
    /// synchronization job is
    /// already in progress, Amazon Kendra returns a `ResourceInUseException`
    /// exception.
    ///
    /// Re-syncing your data source with your index after modifying, adding, or
    /// deleting
    /// documents from your data source respository could take up to an hour or
    /// more, depending on
    /// the number of documents to sync.
    pub fn startDataSourceSyncJob(self: *Self, allocator: std.mem.Allocator, input: start_data_source_sync_job.StartDataSourceSyncJobInput, options: start_data_source_sync_job.Options) !start_data_source_sync_job.StartDataSourceSyncJobOutput {
        return start_data_source_sync_job.execute(self, allocator, input, options);
    }

    /// Stops a synchronization job that is currently running. You can't stop a
    /// scheduled
    /// synchronization job.
    pub fn stopDataSourceSyncJob(self: *Self, allocator: std.mem.Allocator, input: stop_data_source_sync_job.StopDataSourceSyncJobInput, options: stop_data_source_sync_job.Options) !stop_data_source_sync_job.StopDataSourceSyncJobOutput {
        return stop_data_source_sync_job.execute(self, allocator, input, options);
    }

    /// Enables you to provide feedback to Amazon Kendra to improve the
    /// performance of your index.
    ///
    /// `SubmitFeedback` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    pub fn submitFeedback(self: *Self, allocator: std.mem.Allocator, input: submit_feedback.SubmitFeedbackInput, options: submit_feedback.Options) !submit_feedback.SubmitFeedbackOutput {
        return submit_feedback.execute(self, allocator, input, options);
    }

    /// Adds the specified tag to the specified index, FAQ, data source, or other
    /// resource. If
    /// the tag already exists, the existing value is replaced with the new value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from an index, FAQ, data source, or other resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an access control configuration for your documents in an index. This
    /// includes
    /// user and group access information for your documents. This is useful for
    /// user context
    /// filtering, where search results are filtered based on the user or their
    /// group access to
    /// documents.
    ///
    /// You can update an access control configuration you created without indexing
    /// all of
    /// your documents again. For example, your index contains top-secret company
    /// documents that
    /// only certain employees or users should access. You created an 'allow' access
    /// control
    /// configuration for one user who recently joined the 'top-secret' team,
    /// switching from a
    /// team with 'deny' access to top-secret documents. However, the user suddenly
    /// returns to
    /// their previous team and should no longer have access to top secret
    /// documents. You can
    /// update the access control configuration to re-configure access control for
    /// your
    /// documents as circumstances change.
    ///
    /// You call the
    /// [BatchPutDocument](https://docs.aws.amazon.com/kendra/latest/dg/API_BatchPutDocument.html) API to
    /// apply the updated access control configuration, with the
    /// `AccessControlConfigurationId` included in the
    /// [Document](https://docs.aws.amazon.com/kendra/latest/dg/API_Document.html)
    /// object. If you use an S3 bucket as a data source, you synchronize your data
    /// source to
    /// apply the `AccessControlConfigurationId` in the `.metadata.json`
    /// file. Amazon Kendra currently only supports access control configuration for
    /// S3
    /// data sources and documents indexed using the `BatchPutDocument` API.
    ///
    /// You can't configure access control using
    /// `CreateAccessControlConfiguration` for an Amazon Kendra Gen AI Enterprise
    /// Edition index. Amazon Kendra will return a `ValidationException` error for a
    /// `Gen_AI_ENTERPRISE_EDITION` index.
    pub fn updateAccessControlConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_access_control_configuration.UpdateAccessControlConfigurationInput, options: update_access_control_configuration.Options) !update_access_control_configuration.UpdateAccessControlConfigurationOutput {
        return update_access_control_configuration.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Kendra data source connector.
    pub fn updateDataSource(self: *Self, allocator: std.mem.Allocator, input: update_data_source.UpdateDataSourceInput, options: update_data_source.Options) !update_data_source.UpdateDataSourceOutput {
        return update_data_source.execute(self, allocator, input, options);
    }

    /// Updates your Amazon Kendra experience such as a search application. For more
    /// information on
    /// creating a search application experience, see [Building a
    /// search experience with no
    /// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
    pub fn updateExperience(self: *Self, allocator: std.mem.Allocator, input: update_experience.UpdateExperienceInput, options: update_experience.Options) !update_experience.UpdateExperienceOutput {
        return update_experience.execute(self, allocator, input, options);
    }

    /// Updates a set of featured results. Features results are placed
    /// above
    /// all other results for certain queries. You map specific queries to specific
    /// documents
    /// for featuring in the results. If a query contains an exact match of a query,
    /// then one
    /// or more specific documents are featured in the search results.
    pub fn updateFeaturedResultsSet(self: *Self, allocator: std.mem.Allocator, input: update_featured_results_set.UpdateFeaturedResultsSetInput, options: update_featured_results_set.Options) !update_featured_results_set.UpdateFeaturedResultsSetOutput {
        return update_featured_results_set.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Kendra index.
    pub fn updateIndex(self: *Self, allocator: std.mem.Allocator, input: update_index.UpdateIndexInput, options: update_index.Options) !update_index.UpdateIndexOutput {
        return update_index.execute(self, allocator, input, options);
    }

    /// Updates a block list used for query suggestions for an index.
    ///
    /// Updates to a block list might not take effect right away. Amazon Kendra
    /// needs to refresh the entire suggestions list to apply any updates to the
    /// block list. Other changes not related to the block list apply immediately.
    ///
    /// If a block list is updating, then you need to wait for the first update to
    /// finish before submitting another update.
    ///
    /// Amazon Kendra supports partial updates, so you only need to provide the
    /// fields
    /// you want to update.
    ///
    /// `UpdateQuerySuggestionsBlockList` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    pub fn updateQuerySuggestionsBlockList(self: *Self, allocator: std.mem.Allocator, input: update_query_suggestions_block_list.UpdateQuerySuggestionsBlockListInput, options: update_query_suggestions_block_list.Options) !update_query_suggestions_block_list.UpdateQuerySuggestionsBlockListOutput {
        return update_query_suggestions_block_list.execute(self, allocator, input, options);
    }

    /// Updates the settings of query suggestions for an index.
    ///
    /// Amazon Kendra supports partial updates, so you only need to provide
    /// the fields you want to update.
    ///
    /// If an update is currently processing, you
    /// need to wait for the update to finish before making another update.
    ///
    /// Updates to query suggestions settings might not take effect right away.
    /// The time for your updated settings to take effect depends on the updates
    /// made and the number of search queries in your index.
    ///
    /// You can still enable/disable query suggestions at any time.
    ///
    /// `UpdateQuerySuggestionsConfig` is currently not supported in the
    /// Amazon Web Services GovCloud (US-West) region.
    pub fn updateQuerySuggestionsConfig(self: *Self, allocator: std.mem.Allocator, input: update_query_suggestions_config.UpdateQuerySuggestionsConfigInput, options: update_query_suggestions_config.Options) !update_query_suggestions_config.UpdateQuerySuggestionsConfigOutput {
        return update_query_suggestions_config.execute(self, allocator, input, options);
    }

    /// Updates a thesaurus for an index.
    pub fn updateThesaurus(self: *Self, allocator: std.mem.Allocator, input: update_thesaurus.UpdateThesaurusInput, options: update_thesaurus.Options) !update_thesaurus.UpdateThesaurusOutput {
        return update_thesaurus.execute(self, allocator, input, options);
    }

    pub fn getSnapshotsPaginator(self: *Self, params: get_snapshots.GetSnapshotsInput) paginator.GetSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessControlConfigurationsPaginator(self: *Self, params: list_access_control_configurations.ListAccessControlConfigurationsInput) paginator.ListAccessControlConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataSourceSyncJobsPaginator(self: *Self, params: list_data_source_sync_jobs.ListDataSourceSyncJobsInput) paginator.ListDataSourceSyncJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataSourcesPaginator(self: *Self, params: list_data_sources.ListDataSourcesInput) paginator.ListDataSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntityPersonasPaginator(self: *Self, params: list_entity_personas.ListEntityPersonasInput) paginator.ListEntityPersonasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExperienceEntitiesPaginator(self: *Self, params: list_experience_entities.ListExperienceEntitiesInput) paginator.ListExperienceEntitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExperiencesPaginator(self: *Self, params: list_experiences.ListExperiencesInput) paginator.ListExperiencesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFaqsPaginator(self: *Self, params: list_faqs.ListFaqsInput) paginator.ListFaqsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupsOlderThanOrderingIdPaginator(self: *Self, params: list_groups_older_than_ordering_id.ListGroupsOlderThanOrderingIdInput) paginator.ListGroupsOlderThanOrderingIdPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIndicesPaginator(self: *Self, params: list_indices.ListIndicesInput) paginator.ListIndicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQuerySuggestionsBlockListsPaginator(self: *Self, params: list_query_suggestions_block_lists.ListQuerySuggestionsBlockListsInput) paginator.ListQuerySuggestionsBlockListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThesauriPaginator(self: *Self, params: list_thesauri.ListThesauriInput) paginator.ListThesauriPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
