const aws = @import("aws");
const std = @import("std");

const associate_permission = @import("associate_permission.zig");
const batch_delete_document = @import("batch_delete_document.zig");
const batch_put_document = @import("batch_put_document.zig");
const cancel_subscription = @import("cancel_subscription.zig");
const chat_ = @import("chat.zig");
const chat_sync = @import("chat_sync.zig");
const check_document_access = @import("check_document_access.zig");
const create_anonymous_web_experience_url = @import("create_anonymous_web_experience_url.zig");
const create_application = @import("create_application.zig");
const create_chat_response_configuration = @import("create_chat_response_configuration.zig");
const create_data_accessor = @import("create_data_accessor.zig");
const create_data_source = @import("create_data_source.zig");
const create_index = @import("create_index.zig");
const create_plugin = @import("create_plugin.zig");
const create_retriever = @import("create_retriever.zig");
const create_subscription = @import("create_subscription.zig");
const create_user = @import("create_user.zig");
const create_web_experience = @import("create_web_experience.zig");
const delete_application = @import("delete_application.zig");
const delete_attachment = @import("delete_attachment.zig");
const delete_chat_controls_configuration = @import("delete_chat_controls_configuration.zig");
const delete_chat_response_configuration = @import("delete_chat_response_configuration.zig");
const delete_conversation = @import("delete_conversation.zig");
const delete_data_accessor = @import("delete_data_accessor.zig");
const delete_data_source = @import("delete_data_source.zig");
const delete_group = @import("delete_group.zig");
const delete_index = @import("delete_index.zig");
const delete_plugin = @import("delete_plugin.zig");
const delete_retriever = @import("delete_retriever.zig");
const delete_user = @import("delete_user.zig");
const delete_web_experience = @import("delete_web_experience.zig");
const disassociate_permission = @import("disassociate_permission.zig");
const get_application = @import("get_application.zig");
const get_chat_controls_configuration = @import("get_chat_controls_configuration.zig");
const get_chat_response_configuration = @import("get_chat_response_configuration.zig");
const get_data_accessor = @import("get_data_accessor.zig");
const get_data_source = @import("get_data_source.zig");
const get_document_content = @import("get_document_content.zig");
const get_group = @import("get_group.zig");
const get_index = @import("get_index.zig");
const get_media = @import("get_media.zig");
const get_plugin = @import("get_plugin.zig");
const get_policy = @import("get_policy.zig");
const get_retriever = @import("get_retriever.zig");
const get_user = @import("get_user.zig");
const get_web_experience = @import("get_web_experience.zig");
const list_applications = @import("list_applications.zig");
const list_attachments = @import("list_attachments.zig");
const list_chat_response_configurations = @import("list_chat_response_configurations.zig");
const list_conversations = @import("list_conversations.zig");
const list_data_accessors = @import("list_data_accessors.zig");
const list_data_source_sync_jobs = @import("list_data_source_sync_jobs.zig");
const list_data_sources = @import("list_data_sources.zig");
const list_documents = @import("list_documents.zig");
const list_groups = @import("list_groups.zig");
const list_indices = @import("list_indices.zig");
const list_messages = @import("list_messages.zig");
const list_plugin_actions = @import("list_plugin_actions.zig");
const list_plugin_type_actions = @import("list_plugin_type_actions.zig");
const list_plugin_type_metadata = @import("list_plugin_type_metadata.zig");
const list_plugins = @import("list_plugins.zig");
const list_retrievers = @import("list_retrievers.zig");
const list_subscriptions = @import("list_subscriptions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_web_experiences = @import("list_web_experiences.zig");
const put_feedback = @import("put_feedback.zig");
const put_group = @import("put_group.zig");
const search_relevant_content = @import("search_relevant_content.zig");
const start_data_source_sync_job = @import("start_data_source_sync_job.zig");
const stop_data_source_sync_job = @import("stop_data_source_sync_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_chat_controls_configuration = @import("update_chat_controls_configuration.zig");
const update_chat_response_configuration = @import("update_chat_response_configuration.zig");
const update_data_accessor = @import("update_data_accessor.zig");
const update_data_source = @import("update_data_source.zig");
const update_index = @import("update_index.zig");
const update_plugin = @import("update_plugin.zig");
const update_retriever = @import("update_retriever.zig");
const update_subscription = @import("update_subscription.zig");
const update_user = @import("update_user.zig");
const update_web_experience = @import("update_web_experience.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "QBusiness";

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

    /// Adds or updates a permission policy for a Amazon Q Business application,
    /// allowing cross-account access for an ISV. This operation creates a new
    /// policy statement for the specified Amazon Q Business application. The policy
    /// statement defines the IAM actions that the ISV is allowed to perform on the
    /// Amazon Q Business application's resources.
    pub fn associatePermission(self: *Self, allocator: std.mem.Allocator, input: associate_permission.AssociatePermissionInput, options: associate_permission.Options) !associate_permission.AssociatePermissionOutput {
        return associate_permission.execute(self, allocator, input, options);
    }

    /// Asynchronously deletes one or more documents added using the
    /// `BatchPutDocument` API from an Amazon Q Business index.
    ///
    /// You can see the progress of the deletion, and any error messages related to
    /// the process, by using CloudWatch.
    pub fn batchDeleteDocument(self: *Self, allocator: std.mem.Allocator, input: batch_delete_document.BatchDeleteDocumentInput, options: batch_delete_document.Options) !batch_delete_document.BatchDeleteDocumentOutput {
        return batch_delete_document.execute(self, allocator, input, options);
    }

    /// Adds one or more documents to an Amazon Q Business index.
    ///
    /// You use this API to:
    ///
    /// * ingest your structured and unstructured documents and documents stored in
    ///   an Amazon S3 bucket into an Amazon Q Business index.
    /// * add custom attributes to documents in an Amazon Q Business index.
    /// * attach an access control list to the documents added to an Amazon Q
    ///   Business index.
    ///
    /// You can see the progress of the deletion, and any error messages related to
    /// the process, by using CloudWatch.
    pub fn batchPutDocument(self: *Self, allocator: std.mem.Allocator, input: batch_put_document.BatchPutDocumentInput, options: batch_put_document.Options) !batch_put_document.BatchPutDocumentOutput {
        return batch_put_document.execute(self, allocator, input, options);
    }

    /// Unsubscribes a user or a group from their pricing tier in an Amazon Q
    /// Business application. An unsubscribed user or group loses all Amazon Q
    /// Business feature access at the start of next month.
    pub fn cancelSubscription(self: *Self, allocator: std.mem.Allocator, input: cancel_subscription.CancelSubscriptionInput, options: cancel_subscription.Options) !cancel_subscription.CancelSubscriptionOutput {
        return cancel_subscription.execute(self, allocator, input, options);
    }

    /// Starts or continues a streaming Amazon Q Business conversation.
    pub fn chat(self: *Self, allocator: std.mem.Allocator, input: chat_.ChatInput, options: chat_.Options) !chat_.ChatOutput {
        return chat_.execute(self, allocator, input, options);
    }

    /// Starts or continues a non-streaming Amazon Q Business conversation.
    pub fn chatSync(self: *Self, allocator: std.mem.Allocator, input: chat_sync.ChatSyncInput, options: chat_sync.Options) !chat_sync.ChatSyncOutput {
        return chat_sync.execute(self, allocator, input, options);
    }

    /// Verifies if a user has access permissions for a specified document and
    /// returns the actual ACL attached to the document. Resolves user access on the
    /// document via user aliases and groups when verifying user access.
    pub fn checkDocumentAccess(self: *Self, allocator: std.mem.Allocator, input: check_document_access.CheckDocumentAccessInput, options: check_document_access.Options) !check_document_access.CheckDocumentAccessOutput {
        return check_document_access.execute(self, allocator, input, options);
    }

    /// Creates a unique URL for anonymous Amazon Q Business web experience. This
    /// URL can only be used once and must be used within 5 minutes after it's
    /// generated.
    pub fn createAnonymousWebExperienceUrl(self: *Self, allocator: std.mem.Allocator, input: create_anonymous_web_experience_url.CreateAnonymousWebExperienceUrlInput, options: create_anonymous_web_experience_url.Options) !create_anonymous_web_experience_url.CreateAnonymousWebExperienceUrlOutput {
        return create_anonymous_web_experience_url.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q Business application.
    ///
    /// There are new tiers for Amazon Q Business. Not all features in Amazon Q
    /// Business Pro are also available in Amazon Q Business Lite. For information
    /// on what's included in Amazon Q Business Lite and what's included in Amazon Q
    /// Business Pro, see [Amazon Q Business
    /// tiers](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/tiers.html#user-sub-tiers). You must use the Amazon Q Business console to assign subscription tiers to users.
    ///
    /// An Amazon Q Apps service linked role will be created if it's absent in the
    /// Amazon Web Services account when `QAppsConfiguration` is enabled in the
    /// request. For more information, see [ Using service-linked roles for Q
    /// Apps](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/using-service-linked-roles-qapps.html).
    ///
    /// When you create an application, Amazon Q Business may securely transmit data
    /// for processing from your selected Amazon Web Services region, but within
    /// your geography. For more information, see [Cross region inference in Amazon
    /// Q
    /// Business](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/cross-region-inference.html).
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates a new chat response configuration for an Amazon Q Business
    /// application. This operation establishes a set of parameters that define how
    /// the system generates and formats responses to user queries in chat
    /// interactions.
    pub fn createChatResponseConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_chat_response_configuration.CreateChatResponseConfigurationInput, options: create_chat_response_configuration.Options) !create_chat_response_configuration.CreateChatResponseConfigurationOutput {
        return create_chat_response_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new data accessor for an ISV to access data from a Amazon Q
    /// Business application. The data accessor is an entity that represents the
    /// ISV's access to the Amazon Q Business application's data. It includes the
    /// IAM role ARN for the ISV, a friendly name, and a set of action
    /// configurations that define the specific actions the ISV is allowed to
    /// perform and any associated data filters. When the data accessor is created,
    /// an IAM Identity Center application is also created to manage the ISV's
    /// identity and authentication for accessing the Amazon Q Business application.
    pub fn createDataAccessor(self: *Self, allocator: std.mem.Allocator, input: create_data_accessor.CreateDataAccessorInput, options: create_data_accessor.Options) !create_data_accessor.CreateDataAccessorOutput {
        return create_data_accessor.execute(self, allocator, input, options);
    }

    /// Creates a data source connector for an Amazon Q Business application.
    ///
    /// `CreateDataSource` is a synchronous operation. The operation returns 200 if
    /// the data source was successfully created. Otherwise, an exception is raised.
    pub fn createDataSource(self: *Self, allocator: std.mem.Allocator, input: create_data_source.CreateDataSourceInput, options: create_data_source.Options) !create_data_source.CreateDataSourceOutput {
        return create_data_source.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q Business index.
    ///
    /// To determine if index creation has completed, check the `Status` field
    /// returned from a call to `DescribeIndex`. The `Status` field is set to
    /// `ACTIVE` when the index is ready to use.
    ///
    /// Once the index is active, you can index your documents using the [
    /// `BatchPutDocument`
    /// ](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_BatchPutDocument.html) API or the [ `CreateDataSource` ](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_CreateDataSource.html) API.
    pub fn createIndex(self: *Self, allocator: std.mem.Allocator, input: create_index.CreateIndexInput, options: create_index.Options) !create_index.CreateIndexOutput {
        return create_index.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q Business plugin.
    pub fn createPlugin(self: *Self, allocator: std.mem.Allocator, input: create_plugin.CreatePluginInput, options: create_plugin.Options) !create_plugin.CreatePluginOutput {
        return create_plugin.execute(self, allocator, input, options);
    }

    /// Adds a retriever to your Amazon Q Business application.
    pub fn createRetriever(self: *Self, allocator: std.mem.Allocator, input: create_retriever.CreateRetrieverInput, options: create_retriever.Options) !create_retriever.CreateRetrieverOutput {
        return create_retriever.execute(self, allocator, input, options);
    }

    /// Subscribes an IAM Identity Center user or a group to a pricing tier for an
    /// Amazon Q Business application.
    ///
    /// Amazon Q Business offers two subscription tiers: `Q_LITE` and `Q_BUSINESS`.
    /// Subscription tier determines feature access for the user. For more
    /// information on subscriptions and pricing tiers, see [Amazon Q Business
    /// pricing](https://aws.amazon.com/q/business/pricing/).
    ///
    /// For an example IAM role policy for assigning subscriptions, see [Set up
    /// required
    /// permissions](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/setting-up.html#permissions) in the Amazon Q Business User Guide.
    pub fn createSubscription(self: *Self, allocator: std.mem.Allocator, input: create_subscription.CreateSubscriptionInput, options: create_subscription.Options) !create_subscription.CreateSubscriptionOutput {
        return create_subscription.execute(self, allocator, input, options);
    }

    /// Creates a universally unique identifier (UUID) mapped to a list of local
    /// user ids within an application.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: create_user.Options) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q Business web experience.
    pub fn createWebExperience(self: *Self, allocator: std.mem.Allocator, input: create_web_experience.CreateWebExperienceInput, options: create_web_experience.Options) !create_web_experience.CreateWebExperienceOutput {
        return create_web_experience.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q Business application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes an attachment associated with a specific Amazon Q Business
    /// conversation.
    pub fn deleteAttachment(self: *Self, allocator: std.mem.Allocator, input: delete_attachment.DeleteAttachmentInput, options: delete_attachment.Options) !delete_attachment.DeleteAttachmentOutput {
        return delete_attachment.execute(self, allocator, input, options);
    }

    /// Deletes chat controls configured for an existing Amazon Q Business
    /// application.
    pub fn deleteChatControlsConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_chat_controls_configuration.DeleteChatControlsConfigurationInput, options: delete_chat_controls_configuration.Options) !delete_chat_controls_configuration.DeleteChatControlsConfigurationOutput {
        return delete_chat_controls_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a specified chat response configuration from an Amazon Q Business
    /// application.
    pub fn deleteChatResponseConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_chat_response_configuration.DeleteChatResponseConfigurationInput, options: delete_chat_response_configuration.Options) !delete_chat_response_configuration.DeleteChatResponseConfigurationOutput {
        return delete_chat_response_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q Business web experience conversation.
    pub fn deleteConversation(self: *Self, allocator: std.mem.Allocator, input: delete_conversation.DeleteConversationInput, options: delete_conversation.Options) !delete_conversation.DeleteConversationOutput {
        return delete_conversation.execute(self, allocator, input, options);
    }

    /// Deletes a specified data accessor. This operation permanently removes the
    /// data accessor and its associated IAM Identity Center application. Any access
    /// granted to the ISV through this data accessor will be revoked.
    pub fn deleteDataAccessor(self: *Self, allocator: std.mem.Allocator, input: delete_data_accessor.DeleteDataAccessorInput, options: delete_data_accessor.Options) !delete_data_accessor.DeleteDataAccessorOutput {
        return delete_data_accessor.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q Business data source connector. While the data source is
    /// being deleted, the `Status` field returned by a call to the
    /// `DescribeDataSource` API is set to `DELETING`.
    pub fn deleteDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_data_source.DeleteDataSourceInput, options: delete_data_source.Options) !delete_data_source.DeleteDataSourceOutput {
        return delete_data_source.execute(self, allocator, input, options);
    }

    /// Deletes a group so that all users and sub groups that belong to the group
    /// can no longer access documents only available to that group. For example,
    /// after deleting the group "Summer Interns", all interns who belonged to that
    /// group no longer see intern-only documents in their chat results.
    ///
    /// If you want to delete, update, or replace users or sub groups of a group,
    /// you need to use the `PutGroup` operation. For example, if a user in the
    /// group "Engineering" leaves the engineering team and another user takes their
    /// place, you provide an updated list of users or sub groups that belong to the
    /// "Engineering" group when calling `PutGroup`.
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: delete_group.Options) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q Business index.
    pub fn deleteIndex(self: *Self, allocator: std.mem.Allocator, input: delete_index.DeleteIndexInput, options: delete_index.Options) !delete_index.DeleteIndexOutput {
        return delete_index.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q Business plugin.
    pub fn deletePlugin(self: *Self, allocator: std.mem.Allocator, input: delete_plugin.DeletePluginInput, options: delete_plugin.Options) !delete_plugin.DeletePluginOutput {
        return delete_plugin.execute(self, allocator, input, options);
    }

    /// Deletes the retriever used by an Amazon Q Business application.
    pub fn deleteRetriever(self: *Self, allocator: std.mem.Allocator, input: delete_retriever.DeleteRetrieverInput, options: delete_retriever.Options) !delete_retriever.DeleteRetrieverOutput {
        return delete_retriever.execute(self, allocator, input, options);
    }

    /// Deletes a user by email id.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: delete_user.Options) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q Business web experience.
    pub fn deleteWebExperience(self: *Self, allocator: std.mem.Allocator, input: delete_web_experience.DeleteWebExperienceInput, options: delete_web_experience.Options) !delete_web_experience.DeleteWebExperienceOutput {
        return delete_web_experience.execute(self, allocator, input, options);
    }

    /// Removes a permission policy from a Amazon Q Business application, revoking
    /// the cross-account access that was previously granted to an ISV. This
    /// operation deletes the specified policy statement from the application's
    /// permission policy.
    pub fn disassociatePermission(self: *Self, allocator: std.mem.Allocator, input: disassociate_permission.DisassociatePermissionInput, options: disassociate_permission.Options) !disassociate_permission.DisassociatePermissionOutput {
        return disassociate_permission.execute(self, allocator, input, options);
    }

    /// Gets information about an existing Amazon Q Business application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: get_application.Options) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Gets information about chat controls configured for an existing Amazon Q
    /// Business application.
    pub fn getChatControlsConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_chat_controls_configuration.GetChatControlsConfigurationInput, options: get_chat_controls_configuration.Options) !get_chat_controls_configuration.GetChatControlsConfigurationOutput {
        return get_chat_controls_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific chat response configuration
    /// from an Amazon Q Business application. This operation returns the complete
    /// configuration settings and metadata.
    pub fn getChatResponseConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_chat_response_configuration.GetChatResponseConfigurationInput, options: get_chat_response_configuration.Options) !get_chat_response_configuration.GetChatResponseConfigurationOutput {
        return get_chat_response_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specified data accessor. This operation
    /// returns details about the data accessor, including its display name, unique
    /// identifier, Amazon Resource Name (ARN), the associated Amazon Q Business
    /// application and IAM Identity Center application, the IAM role for the ISV,
    /// the action configurations, and the timestamps for when the data accessor was
    /// created and last updated.
    pub fn getDataAccessor(self: *Self, allocator: std.mem.Allocator, input: get_data_accessor.GetDataAccessorInput, options: get_data_accessor.Options) !get_data_accessor.GetDataAccessorOutput {
        return get_data_accessor.execute(self, allocator, input, options);
    }

    /// Gets information about an existing Amazon Q Business data source connector.
    pub fn getDataSource(self: *Self, allocator: std.mem.Allocator, input: get_data_source.GetDataSourceInput, options: get_data_source.Options) !get_data_source.GetDataSourceOutput {
        return get_data_source.execute(self, allocator, input, options);
    }

    /// Retrieves the content of a document that was ingested into Amazon Q
    /// Business. This API validates user authorization against document ACLs before
    /// returning a pre-signed URL for secure document access. You can download or
    /// view source documents referenced in chat responses through the URL.
    pub fn getDocumentContent(self: *Self, allocator: std.mem.Allocator, input: get_document_content.GetDocumentContentInput, options: get_document_content.Options) !get_document_content.GetDocumentContentOutput {
        return get_document_content.execute(self, allocator, input, options);
    }

    /// Describes a group by group name.
    pub fn getGroup(self: *Self, allocator: std.mem.Allocator, input: get_group.GetGroupInput, options: get_group.Options) !get_group.GetGroupOutput {
        return get_group.execute(self, allocator, input, options);
    }

    /// Gets information about an existing Amazon Q Business index.
    pub fn getIndex(self: *Self, allocator: std.mem.Allocator, input: get_index.GetIndexInput, options: get_index.Options) !get_index.GetIndexOutput {
        return get_index.execute(self, allocator, input, options);
    }

    /// Returns the image bytes corresponding to a media object. If you have
    /// implemented your own application with the Chat and ChatSync APIs, and have
    /// enabled content extraction from visual data in Amazon Q Business, you use
    /// the GetMedia API operation to download the images so you can show them in
    /// your UI with responses.
    ///
    /// For more information, see [Extracting semantic meaning from images and
    /// visuals](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/extracting-meaning-from-images.html).
    pub fn getMedia(self: *Self, allocator: std.mem.Allocator, input: get_media.GetMediaInput, options: get_media.Options) !get_media.GetMediaOutput {
        return get_media.execute(self, allocator, input, options);
    }

    /// Gets information about an existing Amazon Q Business plugin.
    pub fn getPlugin(self: *Self, allocator: std.mem.Allocator, input: get_plugin.GetPluginInput, options: get_plugin.Options) !get_plugin.GetPluginOutput {
        return get_plugin.execute(self, allocator, input, options);
    }

    /// Retrieves the current permission policy for a Amazon Q Business application.
    /// The policy is returned as a JSON-formatted string and defines the IAM
    /// actions that are allowed or denied for the application's resources.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: get_policy.Options) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Gets information about an existing retriever used by an Amazon Q Business
    /// application.
    pub fn getRetriever(self: *Self, allocator: std.mem.Allocator, input: get_retriever.GetRetrieverInput, options: get_retriever.Options) !get_retriever.GetRetrieverOutput {
        return get_retriever.execute(self, allocator, input, options);
    }

    /// Describes the universally unique identifier (UUID) associated with a local
    /// user in a data source.
    pub fn getUser(self: *Self, allocator: std.mem.Allocator, input: get_user.GetUserInput, options: get_user.Options) !get_user.GetUserOutput {
        return get_user.execute(self, allocator, input, options);
    }

    /// Gets information about an existing Amazon Q Business web experience.
    pub fn getWebExperience(self: *Self, allocator: std.mem.Allocator, input: get_web_experience.GetWebExperienceInput, options: get_web_experience.Options) !get_web_experience.GetWebExperienceOutput {
        return get_web_experience.execute(self, allocator, input, options);
    }

    /// Lists Amazon Q Business applications.
    ///
    /// Amazon Q Business applications may securely transmit data for processing
    /// across Amazon Web Services Regions within your geography. For more
    /// information, see [Cross region inference in Amazon Q
    /// Business](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/cross-region-inference.html).
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: list_applications.Options) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Gets a list of attachments associated with an Amazon Q Business web
    /// experience or a list of attachements associated with a specific Amazon Q
    /// Business conversation.
    pub fn listAttachments(self: *Self, allocator: std.mem.Allocator, input: list_attachments.ListAttachmentsInput, options: list_attachments.Options) !list_attachments.ListAttachmentsOutput {
        return list_attachments.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all chat response configurations available in a
    /// specified Amazon Q Business application. This operation returns summary
    /// information about each configuration to help administrators manage and
    /// select appropriate response settings.
    pub fn listChatResponseConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_chat_response_configurations.ListChatResponseConfigurationsInput, options: list_chat_response_configurations.Options) !list_chat_response_configurations.ListChatResponseConfigurationsOutput {
        return list_chat_response_configurations.execute(self, allocator, input, options);
    }

    /// Lists one or more Amazon Q Business conversations.
    pub fn listConversations(self: *Self, allocator: std.mem.Allocator, input: list_conversations.ListConversationsInput, options: list_conversations.Options) !list_conversations.ListConversationsOutput {
        return list_conversations.execute(self, allocator, input, options);
    }

    /// Lists the data accessors for a Amazon Q Business application. This operation
    /// returns a paginated list of data accessor summaries, including the friendly
    /// name, unique identifier, ARN, associated IAM role, and creation/update
    /// timestamps for each data accessor.
    pub fn listDataAccessors(self: *Self, allocator: std.mem.Allocator, input: list_data_accessors.ListDataAccessorsInput, options: list_data_accessors.Options) !list_data_accessors.ListDataAccessorsOutput {
        return list_data_accessors.execute(self, allocator, input, options);
    }

    /// Get information about an Amazon Q Business data source connector
    /// synchronization.
    pub fn listDataSourceSyncJobs(self: *Self, allocator: std.mem.Allocator, input: list_data_source_sync_jobs.ListDataSourceSyncJobsInput, options: list_data_source_sync_jobs.Options) !list_data_source_sync_jobs.ListDataSourceSyncJobsOutput {
        return list_data_source_sync_jobs.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Q Business data source connectors that you have created.
    pub fn listDataSources(self: *Self, allocator: std.mem.Allocator, input: list_data_sources.ListDataSourcesInput, options: list_data_sources.Options) !list_data_sources.ListDataSourcesOutput {
        return list_data_sources.execute(self, allocator, input, options);
    }

    /// A list of documents attached to an index.
    pub fn listDocuments(self: *Self, allocator: std.mem.Allocator, input: list_documents.ListDocumentsInput, options: list_documents.Options) !list_documents.ListDocumentsOutput {
        return list_documents.execute(self, allocator, input, options);
    }

    /// Provides a list of groups that are mapped to users.
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: list_groups.Options) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Q Business indices you have created.
    pub fn listIndices(self: *Self, allocator: std.mem.Allocator, input: list_indices.ListIndicesInput, options: list_indices.Options) !list_indices.ListIndicesOutput {
        return list_indices.execute(self, allocator, input, options);
    }

    /// Gets a list of messages associated with an Amazon Q Business web experience.
    pub fn listMessages(self: *Self, allocator: std.mem.Allocator, input: list_messages.ListMessagesInput, options: list_messages.Options) !list_messages.ListMessagesOutput {
        return list_messages.execute(self, allocator, input, options);
    }

    /// Lists configured Amazon Q Business actions for a specific plugin in an
    /// Amazon Q Business application.
    pub fn listPluginActions(self: *Self, allocator: std.mem.Allocator, input: list_plugin_actions.ListPluginActionsInput, options: list_plugin_actions.Options) !list_plugin_actions.ListPluginActionsOutput {
        return list_plugin_actions.execute(self, allocator, input, options);
    }

    /// Lists configured Amazon Q Business actions for any plugin type—both built-in
    /// and custom.
    pub fn listPluginTypeActions(self: *Self, allocator: std.mem.Allocator, input: list_plugin_type_actions.ListPluginTypeActionsInput, options: list_plugin_type_actions.Options) !list_plugin_type_actions.ListPluginTypeActionsOutput {
        return list_plugin_type_actions.execute(self, allocator, input, options);
    }

    /// Lists metadata for all Amazon Q Business plugin types.
    pub fn listPluginTypeMetadata(self: *Self, allocator: std.mem.Allocator, input: list_plugin_type_metadata.ListPluginTypeMetadataInput, options: list_plugin_type_metadata.Options) !list_plugin_type_metadata.ListPluginTypeMetadataOutput {
        return list_plugin_type_metadata.execute(self, allocator, input, options);
    }

    /// Lists configured Amazon Q Business plugins.
    pub fn listPlugins(self: *Self, allocator: std.mem.Allocator, input: list_plugins.ListPluginsInput, options: list_plugins.Options) !list_plugins.ListPluginsOutput {
        return list_plugins.execute(self, allocator, input, options);
    }

    /// Lists the retriever used by an Amazon Q Business application.
    pub fn listRetrievers(self: *Self, allocator: std.mem.Allocator, input: list_retrievers.ListRetrieversInput, options: list_retrievers.Options) !list_retrievers.ListRetrieversOutput {
        return list_retrievers.execute(self, allocator, input, options);
    }

    /// Lists all subscriptions created in an Amazon Q Business application.
    pub fn listSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_subscriptions.ListSubscriptionsInput, options: list_subscriptions.Options) !list_subscriptions.ListSubscriptionsOutput {
        return list_subscriptions.execute(self, allocator, input, options);
    }

    /// Gets a list of tags associated with a specified resource. Amazon Q Business
    /// applications and data sources can have tags associated with them.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists one or more Amazon Q Business Web Experiences.
    pub fn listWebExperiences(self: *Self, allocator: std.mem.Allocator, input: list_web_experiences.ListWebExperiencesInput, options: list_web_experiences.Options) !list_web_experiences.ListWebExperiencesOutput {
        return list_web_experiences.execute(self, allocator, input, options);
    }

    /// Enables your end user to provide feedback on their Amazon Q Business
    /// generated chat responses.
    pub fn putFeedback(self: *Self, allocator: std.mem.Allocator, input: put_feedback.PutFeedbackInput, options: put_feedback.Options) !put_feedback.PutFeedbackOutput {
        return put_feedback.execute(self, allocator, input, options);
    }

    /// Create, or updates, a mapping of users—who have access to a document—to
    /// groups.
    ///
    /// You can also map sub groups to groups. For example, the group "Company
    /// Intellectual Property Teams" includes sub groups "Research" and
    /// "Engineering". These sub groups include their own list of users or people
    /// who work in these teams. Only users who work in research and engineering,
    /// and therefore belong in the intellectual property group, can see top-secret
    /// company documents in their Amazon Q Business chat results.
    ///
    /// There are two options for creating groups, either passing group members
    /// inline or using an S3 file via the S3PathForGroupMembers field. For inline
    /// groups, there is a limit of 1000 members per group and for provided S3 files
    /// there is a limit of 100 thousand members. When creating a group using an S3
    /// file, you provide both an S3 file and a `RoleArn` for Amazon Q Buisness to
    /// access the file.
    pub fn putGroup(self: *Self, allocator: std.mem.Allocator, input: put_group.PutGroupInput, options: put_group.Options) !put_group.PutGroupOutput {
        return put_group.execute(self, allocator, input, options);
    }

    /// Searches for relevant content in a Amazon Q Business application based on a
    /// query. This operation takes a search query text, the Amazon Q Business
    /// application identifier, and optional filters (such as content source and
    /// maximum results) as input. It returns a list of relevant content items,
    /// where each item includes the content text, the unique document identifier,
    /// the document title, the document URI, any relevant document attributes, and
    /// score attributes indicating the confidence level of the relevance.
    pub fn searchRelevantContent(self: *Self, allocator: std.mem.Allocator, input: search_relevant_content.SearchRelevantContentInput, options: search_relevant_content.Options) !search_relevant_content.SearchRelevantContentOutput {
        return search_relevant_content.execute(self, allocator, input, options);
    }

    /// Starts a data source connector synchronization job. If a synchronization job
    /// is already in progress, Amazon Q Business returns a `ConflictException`.
    pub fn startDataSourceSyncJob(self: *Self, allocator: std.mem.Allocator, input: start_data_source_sync_job.StartDataSourceSyncJobInput, options: start_data_source_sync_job.Options) !start_data_source_sync_job.StartDataSourceSyncJobOutput {
        return start_data_source_sync_job.execute(self, allocator, input, options);
    }

    /// Stops an Amazon Q Business data source connector synchronization job already
    /// in progress.
    pub fn stopDataSourceSyncJob(self: *Self, allocator: std.mem.Allocator, input: stop_data_source_sync_job.StopDataSourceSyncJobInput, options: stop_data_source_sync_job.Options) !stop_data_source_sync_job.StopDataSourceSyncJobOutput {
        return stop_data_source_sync_job.execute(self, allocator, input, options);
    }

    /// Adds the specified tag to the specified Amazon Q Business application or
    /// data source resource. If the tag already exists, the existing value is
    /// replaced with the new value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from an Amazon Q Business application or a data source.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Q Business application.
    ///
    /// Amazon Q Business applications may securely transmit data for processing
    /// across Amazon Web Services Regions within your geography. For more
    /// information, see [Cross region inference in Amazon Q
    /// Business](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/cross-region-inference.html).
    ///
    /// An Amazon Q Apps service-linked role will be created if it's absent in the
    /// Amazon Web Services account when `QAppsConfiguration` is enabled in the
    /// request. For more information, see [Using service-linked roles for Q
    /// Apps](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/using-service-linked-roles-qapps.html).
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates a set of chat controls configured for an existing Amazon Q Business
    /// application.
    pub fn updateChatControlsConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_chat_controls_configuration.UpdateChatControlsConfigurationInput, options: update_chat_controls_configuration.Options) !update_chat_controls_configuration.UpdateChatControlsConfigurationOutput {
        return update_chat_controls_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing chat response configuration in an Amazon Q Business
    /// application. This operation allows administrators to modify configuration
    /// settings, display name, and response parameters to refine how the system
    /// generates responses.
    pub fn updateChatResponseConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_chat_response_configuration.UpdateChatResponseConfigurationInput, options: update_chat_response_configuration.Options) !update_chat_response_configuration.UpdateChatResponseConfigurationOutput {
        return update_chat_response_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing data accessor. This operation allows modifying the
    /// action configurations (the allowed actions and associated filters) and the
    /// display name of the data accessor. It does not allow changing the IAM role
    /// associated with the data accessor or other core properties of the data
    /// accessor.
    pub fn updateDataAccessor(self: *Self, allocator: std.mem.Allocator, input: update_data_accessor.UpdateDataAccessorInput, options: update_data_accessor.Options) !update_data_accessor.UpdateDataAccessorOutput {
        return update_data_accessor.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Q Business data source connector.
    pub fn updateDataSource(self: *Self, allocator: std.mem.Allocator, input: update_data_source.UpdateDataSourceInput, options: update_data_source.Options) !update_data_source.UpdateDataSourceOutput {
        return update_data_source.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Q Business index.
    pub fn updateIndex(self: *Self, allocator: std.mem.Allocator, input: update_index.UpdateIndexInput, options: update_index.Options) !update_index.UpdateIndexOutput {
        return update_index.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Q Business plugin.
    pub fn updatePlugin(self: *Self, allocator: std.mem.Allocator, input: update_plugin.UpdatePluginInput, options: update_plugin.Options) !update_plugin.UpdatePluginOutput {
        return update_plugin.execute(self, allocator, input, options);
    }

    /// Updates the retriever used for your Amazon Q Business application.
    pub fn updateRetriever(self: *Self, allocator: std.mem.Allocator, input: update_retriever.UpdateRetrieverInput, options: update_retriever.Options) !update_retriever.UpdateRetrieverOutput {
        return update_retriever.execute(self, allocator, input, options);
    }

    /// Updates the pricing tier for an Amazon Q Business subscription. Upgrades are
    /// instant. Downgrades apply at the start of the next month. Subscription tier
    /// determines feature access for the user. For more information on
    /// subscriptions and pricing tiers, see [Amazon Q Business
    /// pricing](https://aws.amazon.com/q/business/pricing/).
    pub fn updateSubscription(self: *Self, allocator: std.mem.Allocator, input: update_subscription.UpdateSubscriptionInput, options: update_subscription.Options) !update_subscription.UpdateSubscriptionOutput {
        return update_subscription.execute(self, allocator, input, options);
    }

    /// Updates a information associated with a user id.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: update_user.Options) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Q Business web experience.
    pub fn updateWebExperience(self: *Self, allocator: std.mem.Allocator, input: update_web_experience.UpdateWebExperienceInput, options: update_web_experience.Options) !update_web_experience.UpdateWebExperienceOutput {
        return update_web_experience.execute(self, allocator, input, options);
    }

    pub fn getChatControlsConfigurationPaginator(self: *Self, params: get_chat_controls_configuration.GetChatControlsConfigurationInput) paginator.GetChatControlsConfigurationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttachmentsPaginator(self: *Self, params: list_attachments.ListAttachmentsInput) paginator.ListAttachmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChatResponseConfigurationsPaginator(self: *Self, params: list_chat_response_configurations.ListChatResponseConfigurationsInput) paginator.ListChatResponseConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConversationsPaginator(self: *Self, params: list_conversations.ListConversationsInput) paginator.ListConversationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataAccessorsPaginator(self: *Self, params: list_data_accessors.ListDataAccessorsInput) paginator.ListDataAccessorsPaginator {
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

    pub fn listDocumentsPaginator(self: *Self, params: list_documents.ListDocumentsInput) paginator.ListDocumentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupsPaginator(self: *Self, params: list_groups.ListGroupsInput) paginator.ListGroupsPaginator {
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

    pub fn listMessagesPaginator(self: *Self, params: list_messages.ListMessagesInput) paginator.ListMessagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPluginActionsPaginator(self: *Self, params: list_plugin_actions.ListPluginActionsInput) paginator.ListPluginActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPluginTypeActionsPaginator(self: *Self, params: list_plugin_type_actions.ListPluginTypeActionsInput) paginator.ListPluginTypeActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPluginTypeMetadataPaginator(self: *Self, params: list_plugin_type_metadata.ListPluginTypeMetadataInput) paginator.ListPluginTypeMetadataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPluginsPaginator(self: *Self, params: list_plugins.ListPluginsInput) paginator.ListPluginsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRetrieversPaginator(self: *Self, params: list_retrievers.ListRetrieversInput) paginator.ListRetrieversPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSubscriptionsPaginator(self: *Self, params: list_subscriptions.ListSubscriptionsInput) paginator.ListSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWebExperiencesPaginator(self: *Self, params: list_web_experiences.ListWebExperiencesInput) paginator.ListWebExperiencesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchRelevantContentPaginator(self: *Self, params: search_relevant_content.SearchRelevantContentInput) paginator.SearchRelevantContentPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
