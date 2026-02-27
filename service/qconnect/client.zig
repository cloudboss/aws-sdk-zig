const aws = @import("aws");
const std = @import("std");

const activate_message_template = @import("activate_message_template.zig");
const create_ai_agent = @import("create_ai_agent.zig");
const create_ai_agent_version = @import("create_ai_agent_version.zig");
const create_ai_guardrail = @import("create_ai_guardrail.zig");
const create_ai_guardrail_version = @import("create_ai_guardrail_version.zig");
const create_ai_prompt = @import("create_ai_prompt.zig");
const create_ai_prompt_version = @import("create_ai_prompt_version.zig");
const create_assistant = @import("create_assistant.zig");
const create_assistant_association = @import("create_assistant_association.zig");
const create_content = @import("create_content.zig");
const create_content_association = @import("create_content_association.zig");
const create_knowledge_base = @import("create_knowledge_base.zig");
const create_message_template = @import("create_message_template.zig");
const create_message_template_attachment = @import("create_message_template_attachment.zig");
const create_message_template_version = @import("create_message_template_version.zig");
const create_quick_response = @import("create_quick_response.zig");
const create_session = @import("create_session.zig");
const deactivate_message_template = @import("deactivate_message_template.zig");
const delete_ai_agent = @import("delete_ai_agent.zig");
const delete_ai_agent_version = @import("delete_ai_agent_version.zig");
const delete_ai_guardrail = @import("delete_ai_guardrail.zig");
const delete_ai_guardrail_version = @import("delete_ai_guardrail_version.zig");
const delete_ai_prompt = @import("delete_ai_prompt.zig");
const delete_ai_prompt_version = @import("delete_ai_prompt_version.zig");
const delete_assistant = @import("delete_assistant.zig");
const delete_assistant_association = @import("delete_assistant_association.zig");
const delete_content = @import("delete_content.zig");
const delete_content_association = @import("delete_content_association.zig");
const delete_import_job = @import("delete_import_job.zig");
const delete_knowledge_base = @import("delete_knowledge_base.zig");
const delete_message_template = @import("delete_message_template.zig");
const delete_message_template_attachment = @import("delete_message_template_attachment.zig");
const delete_quick_response = @import("delete_quick_response.zig");
const get_ai_agent = @import("get_ai_agent.zig");
const get_ai_guardrail = @import("get_ai_guardrail.zig");
const get_ai_prompt = @import("get_ai_prompt.zig");
const get_assistant = @import("get_assistant.zig");
const get_assistant_association = @import("get_assistant_association.zig");
const get_content = @import("get_content.zig");
const get_content_association = @import("get_content_association.zig");
const get_content_summary = @import("get_content_summary.zig");
const get_import_job = @import("get_import_job.zig");
const get_knowledge_base = @import("get_knowledge_base.zig");
const get_message_template = @import("get_message_template.zig");
const get_next_message = @import("get_next_message.zig");
const get_quick_response = @import("get_quick_response.zig");
const get_recommendations = @import("get_recommendations.zig");
const get_session = @import("get_session.zig");
const list_ai_agent_versions = @import("list_ai_agent_versions.zig");
const list_ai_agents = @import("list_ai_agents.zig");
const list_ai_guardrail_versions = @import("list_ai_guardrail_versions.zig");
const list_ai_guardrails = @import("list_ai_guardrails.zig");
const list_ai_prompt_versions = @import("list_ai_prompt_versions.zig");
const list_ai_prompts = @import("list_ai_prompts.zig");
const list_assistant_associations = @import("list_assistant_associations.zig");
const list_assistants = @import("list_assistants.zig");
const list_content_associations = @import("list_content_associations.zig");
const list_contents = @import("list_contents.zig");
const list_import_jobs = @import("list_import_jobs.zig");
const list_knowledge_bases = @import("list_knowledge_bases.zig");
const list_message_template_versions = @import("list_message_template_versions.zig");
const list_message_templates = @import("list_message_templates.zig");
const list_messages = @import("list_messages.zig");
const list_quick_responses = @import("list_quick_responses.zig");
const list_spans = @import("list_spans.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const notify_recommendations_received = @import("notify_recommendations_received.zig");
const put_feedback = @import("put_feedback.zig");
const query_assistant = @import("query_assistant.zig");
const remove_assistant_ai_agent = @import("remove_assistant_ai_agent.zig");
const remove_knowledge_base_template_uri = @import("remove_knowledge_base_template_uri.zig");
const render_message_template = @import("render_message_template.zig");
const retrieve_ = @import("retrieve.zig");
const search_content = @import("search_content.zig");
const search_message_templates = @import("search_message_templates.zig");
const search_quick_responses = @import("search_quick_responses.zig");
const search_sessions = @import("search_sessions.zig");
const send_message = @import("send_message.zig");
const start_content_upload = @import("start_content_upload.zig");
const start_import_job = @import("start_import_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_ai_agent = @import("update_ai_agent.zig");
const update_ai_guardrail = @import("update_ai_guardrail.zig");
const update_ai_prompt = @import("update_ai_prompt.zig");
const update_assistant_ai_agent = @import("update_assistant_ai_agent.zig");
const update_content = @import("update_content.zig");
const update_knowledge_base_template_uri = @import("update_knowledge_base_template_uri.zig");
const update_message_template = @import("update_message_template.zig");
const update_message_template_metadata = @import("update_message_template_metadata.zig");
const update_quick_response = @import("update_quick_response.zig");
const update_session = @import("update_session.zig");
const update_session_data = @import("update_session_data.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "QConnect";

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

    /// Activates a specific version of the Amazon Q in Connect message template.
    /// After the version is activated, the previous active version will be
    /// deactivated automatically. You can use the `$ACTIVE_VERSION` qualifier later
    /// to reference the version that is in active status.
    pub fn activateMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: activate_message_template.ActivateMessageTemplateInput, options: activate_message_template.Options) !activate_message_template.ActivateMessageTemplateOutput {
        return activate_message_template.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q in Connect AI Agent.
    pub fn createAiAgent(self: *Self, allocator: std.mem.Allocator, input: create_ai_agent.CreateAIAgentInput, options: create_ai_agent.Options) !create_ai_agent.CreateAIAgentOutput {
        return create_ai_agent.execute(self, allocator, input, options);
    }

    /// Creates and Amazon Q in Connect AI Agent version.
    pub fn createAiAgentVersion(self: *Self, allocator: std.mem.Allocator, input: create_ai_agent_version.CreateAIAgentVersionInput, options: create_ai_agent_version.Options) !create_ai_agent_version.CreateAIAgentVersionOutput {
        return create_ai_agent_version.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q in Connect AI Guardrail.
    pub fn createAiGuardrail(self: *Self, allocator: std.mem.Allocator, input: create_ai_guardrail.CreateAIGuardrailInput, options: create_ai_guardrail.Options) !create_ai_guardrail.CreateAIGuardrailOutput {
        return create_ai_guardrail.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q in Connect AI Guardrail version.
    pub fn createAiGuardrailVersion(self: *Self, allocator: std.mem.Allocator, input: create_ai_guardrail_version.CreateAIGuardrailVersionInput, options: create_ai_guardrail_version.Options) !create_ai_guardrail_version.CreateAIGuardrailVersionOutput {
        return create_ai_guardrail_version.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q in Connect AI Prompt.
    pub fn createAiPrompt(self: *Self, allocator: std.mem.Allocator, input: create_ai_prompt.CreateAIPromptInput, options: create_ai_prompt.Options) !create_ai_prompt.CreateAIPromptOutput {
        return create_ai_prompt.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q in Connect AI Prompt version.
    pub fn createAiPromptVersion(self: *Self, allocator: std.mem.Allocator, input: create_ai_prompt_version.CreateAIPromptVersionInput, options: create_ai_prompt_version.Options) !create_ai_prompt_version.CreateAIPromptVersionOutput {
        return create_ai_prompt_version.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q in Connect assistant.
    pub fn createAssistant(self: *Self, allocator: std.mem.Allocator, input: create_assistant.CreateAssistantInput, options: create_assistant.Options) !create_assistant.CreateAssistantOutput {
        return create_assistant.execute(self, allocator, input, options);
    }

    /// Creates an association between an Amazon Q in Connect assistant and another
    /// resource. Currently, the only supported association is with a knowledge
    /// base. An assistant can have only a single association.
    pub fn createAssistantAssociation(self: *Self, allocator: std.mem.Allocator, input: create_assistant_association.CreateAssistantAssociationInput, options: create_assistant_association.Options) !create_assistant_association.CreateAssistantAssociationOutput {
        return create_assistant_association.execute(self, allocator, input, options);
    }

    /// Creates Amazon Q in Connect content. Before to calling this API, use
    /// [StartContentUpload](https://docs.aws.amazon.com/amazon-q-connect/latest/APIReference/API_StartContentUpload.html) to upload an asset.
    pub fn createContent(self: *Self, allocator: std.mem.Allocator, input: create_content.CreateContentInput, options: create_content.Options) !create_content.CreateContentOutput {
        return create_content.execute(self, allocator, input, options);
    }

    /// Creates an association between a content resource in a knowledge base and
    /// [step-by-step
    /// guides](https://docs.aws.amazon.com/connect/latest/adminguide/step-by-step-guided-experiences.html). Step-by-step guides offer instructions to agents for resolving common customer issues. You create a content association to integrate Amazon Q in Connect and step-by-step guides.
    ///
    /// After you integrate Amazon Q and step-by-step guides, when Amazon Q provides
    /// a recommendation to an agent based on the intent that it's detected, it also
    /// provides them with the option to start the step-by-step guide that you have
    /// associated with the content.
    ///
    /// Note the following limitations:
    ///
    /// * You can create only one content association for each content resource in a
    ///   knowledge base.
    /// * You can associate a step-by-step guide with multiple content resources.
    ///
    /// For more information, see [Integrate Amazon Q in Connect with step-by-step
    /// guides](https://docs.aws.amazon.com/connect/latest/adminguide/integrate-q-with-guides.html) in the *Amazon Connect Administrator Guide*.
    pub fn createContentAssociation(self: *Self, allocator: std.mem.Allocator, input: create_content_association.CreateContentAssociationInput, options: create_content_association.Options) !create_content_association.CreateContentAssociationOutput {
        return create_content_association.execute(self, allocator, input, options);
    }

    /// Creates a knowledge base.
    ///
    /// When using this API, you cannot reuse [Amazon
    /// AppIntegrations](https://docs.aws.amazon.com/appintegrations/latest/APIReference/Welcome.html) DataIntegrations with external knowledge bases such as Salesforce and ServiceNow. If you do, you'll get an `InvalidRequestException` error.
    ///
    /// For example, you're programmatically managing your external knowledge base,
    /// and you want to add or remove one of the fields that is being ingested from
    /// Salesforce. Do the following:
    ///
    /// * Call
    ///   [DeleteKnowledgeBase](https://docs.aws.amazon.com/amazon-q-connect/latest/APIReference/API_DeleteKnowledgeBase.html).
    /// * Call
    ///   [DeleteDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_DeleteDataIntegration.html).
    /// * Call
    ///   [CreateDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_CreateDataIntegration.html) to recreate the DataIntegration or a create different one.
    /// * Call CreateKnowledgeBase.
    pub fn createKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: create_knowledge_base.CreateKnowledgeBaseInput, options: create_knowledge_base.Options) !create_knowledge_base.CreateKnowledgeBaseOutput {
        return create_knowledge_base.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q in Connect message template. The name of the message
    /// template has to be unique for each knowledge base. The channel subtype of
    /// the message template is immutable and cannot be modified after creation.
    /// After the message template is created, you can use the `$LATEST` qualifier
    /// to reference the created message template.
    pub fn createMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: create_message_template.CreateMessageTemplateInput, options: create_message_template.Options) !create_message_template.CreateMessageTemplateOutput {
        return create_message_template.execute(self, allocator, input, options);
    }

    /// Uploads an attachment file to the specified Amazon Q in Connect message
    /// template. The name of the message template attachment has to be unique for
    /// each message template referenced by the `$LATEST` qualifier. The body of the
    /// attachment file should be encoded using base64 encoding. After the file is
    /// uploaded, you can use the pre-signed Amazon S3 URL returned in response to
    /// download the uploaded file.
    pub fn createMessageTemplateAttachment(self: *Self, allocator: std.mem.Allocator, input: create_message_template_attachment.CreateMessageTemplateAttachmentInput, options: create_message_template_attachment.Options) !create_message_template_attachment.CreateMessageTemplateAttachmentOutput {
        return create_message_template_attachment.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Q in Connect message template version from the current
    /// content and configuration of a message template. Versions are immutable and
    /// monotonically increasing. Once a version is created, you can reference a
    /// specific version of the message template by passing in
    /// `<message-template-id>:<versionNumber>` as the message template identifier.
    /// An error is displayed if the supplied `messageTemplateContentSha256` is
    /// different from the `messageTemplateContentSha256` of the message template
    /// with `$LATEST` qualifier. If multiple `CreateMessageTemplateVersion`
    /// requests are made while the message template remains the same, only the
    /// first invocation creates a new version and the succeeding requests will
    /// return the same response as the first invocation.
    pub fn createMessageTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: create_message_template_version.CreateMessageTemplateVersionInput, options: create_message_template_version.Options) !create_message_template_version.CreateMessageTemplateVersionOutput {
        return create_message_template_version.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Q in Connect quick response.
    pub fn createQuickResponse(self: *Self, allocator: std.mem.Allocator, input: create_quick_response.CreateQuickResponseInput, options: create_quick_response.Options) !create_quick_response.CreateQuickResponseOutput {
        return create_quick_response.execute(self, allocator, input, options);
    }

    /// Creates a session. A session is a contextual container used for generating
    /// recommendations. Amazon Connect creates a new Amazon Q in Connect session
    /// for each contact on which Amazon Q in Connect is enabled.
    pub fn createSession(self: *Self, allocator: std.mem.Allocator, input: create_session.CreateSessionInput, options: create_session.Options) !create_session.CreateSessionOutput {
        return create_session.execute(self, allocator, input, options);
    }

    /// Deactivates a specific version of the Amazon Q in Connect message template .
    /// After the version is deactivated, you can no longer use the
    /// `$ACTIVE_VERSION` qualifier to reference the version in active status.
    pub fn deactivateMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: deactivate_message_template.DeactivateMessageTemplateInput, options: deactivate_message_template.Options) !deactivate_message_template.DeactivateMessageTemplateOutput {
        return deactivate_message_template.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q in Connect AI Agent.
    pub fn deleteAiAgent(self: *Self, allocator: std.mem.Allocator, input: delete_ai_agent.DeleteAIAgentInput, options: delete_ai_agent.Options) !delete_ai_agent.DeleteAIAgentOutput {
        return delete_ai_agent.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q in Connect AI Agent Version.
    pub fn deleteAiAgentVersion(self: *Self, allocator: std.mem.Allocator, input: delete_ai_agent_version.DeleteAIAgentVersionInput, options: delete_ai_agent_version.Options) !delete_ai_agent_version.DeleteAIAgentVersionOutput {
        return delete_ai_agent_version.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q in Connect AI Guardrail.
    pub fn deleteAiGuardrail(self: *Self, allocator: std.mem.Allocator, input: delete_ai_guardrail.DeleteAIGuardrailInput, options: delete_ai_guardrail.Options) !delete_ai_guardrail.DeleteAIGuardrailOutput {
        return delete_ai_guardrail.execute(self, allocator, input, options);
    }

    /// Delete and Amazon Q in Connect AI Guardrail version.
    pub fn deleteAiGuardrailVersion(self: *Self, allocator: std.mem.Allocator, input: delete_ai_guardrail_version.DeleteAIGuardrailVersionInput, options: delete_ai_guardrail_version.Options) !delete_ai_guardrail_version.DeleteAIGuardrailVersionOutput {
        return delete_ai_guardrail_version.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q in Connect AI Prompt.
    pub fn deleteAiPrompt(self: *Self, allocator: std.mem.Allocator, input: delete_ai_prompt.DeleteAIPromptInput, options: delete_ai_prompt.Options) !delete_ai_prompt.DeleteAIPromptOutput {
        return delete_ai_prompt.execute(self, allocator, input, options);
    }

    /// Delete and Amazon Q in Connect AI Prompt version.
    pub fn deleteAiPromptVersion(self: *Self, allocator: std.mem.Allocator, input: delete_ai_prompt_version.DeleteAIPromptVersionInput, options: delete_ai_prompt_version.Options) !delete_ai_prompt_version.DeleteAIPromptVersionOutput {
        return delete_ai_prompt_version.execute(self, allocator, input, options);
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

    /// Deletes the content association.
    ///
    /// For more information about content associations--what they are and when they
    /// are used--see [Integrate Amazon Q in Connect with step-by-step
    /// guides](https://docs.aws.amazon.com/connect/latest/adminguide/integrate-q-with-guides.html) in the *Amazon Connect Administrator Guide*.
    pub fn deleteContentAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_content_association.DeleteContentAssociationInput, options: delete_content_association.Options) !delete_content_association.DeleteContentAssociationOutput {
        return delete_content_association.execute(self, allocator, input, options);
    }

    /// Deletes the quick response import job.
    pub fn deleteImportJob(self: *Self, allocator: std.mem.Allocator, input: delete_import_job.DeleteImportJobInput, options: delete_import_job.Options) !delete_import_job.DeleteImportJobOutput {
        return delete_import_job.execute(self, allocator, input, options);
    }

    /// Deletes the knowledge base.
    ///
    /// When you use this API to delete an external knowledge base such as
    /// Salesforce or ServiceNow, you must also delete the [Amazon
    /// AppIntegrations](https://docs.aws.amazon.com/appintegrations/latest/APIReference/Welcome.html) DataIntegration. This is because you can't reuse the DataIntegration after it's been associated with an external knowledge base. However, you can delete and recreate it. See [DeleteDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_DeleteDataIntegration.html) and [CreateDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_CreateDataIntegration.html) in the *Amazon AppIntegrations API Reference*.
    pub fn deleteKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: delete_knowledge_base.DeleteKnowledgeBaseInput, options: delete_knowledge_base.Options) !delete_knowledge_base.DeleteKnowledgeBaseOutput {
        return delete_knowledge_base.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q in Connect message template entirely or a specific
    /// version of the message template if version is supplied in the request. You
    /// can provide the message template identifier as
    /// `<message-template-id>:<versionNumber>` to delete a specific version of the
    /// message template. If it is not supplied, the message template and all
    /// available versions will be deleted.
    pub fn deleteMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_message_template.DeleteMessageTemplateInput, options: delete_message_template.Options) !delete_message_template.DeleteMessageTemplateOutput {
        return delete_message_template.execute(self, allocator, input, options);
    }

    /// Deletes the attachment file from the Amazon Q in Connect message template
    /// that is referenced by `$LATEST` qualifier. Attachments on available message
    /// template versions will remain unchanged.
    pub fn deleteMessageTemplateAttachment(self: *Self, allocator: std.mem.Allocator, input: delete_message_template_attachment.DeleteMessageTemplateAttachmentInput, options: delete_message_template_attachment.Options) !delete_message_template_attachment.DeleteMessageTemplateAttachmentOutput {
        return delete_message_template_attachment.execute(self, allocator, input, options);
    }

    /// Deletes a quick response.
    pub fn deleteQuickResponse(self: *Self, allocator: std.mem.Allocator, input: delete_quick_response.DeleteQuickResponseInput, options: delete_quick_response.Options) !delete_quick_response.DeleteQuickResponseOutput {
        return delete_quick_response.execute(self, allocator, input, options);
    }

    /// Gets an Amazon Q in Connect AI Agent.
    pub fn getAiAgent(self: *Self, allocator: std.mem.Allocator, input: get_ai_agent.GetAIAgentInput, options: get_ai_agent.Options) !get_ai_agent.GetAIAgentOutput {
        return get_ai_agent.execute(self, allocator, input, options);
    }

    /// Gets the Amazon Q in Connect AI Guardrail.
    pub fn getAiGuardrail(self: *Self, allocator: std.mem.Allocator, input: get_ai_guardrail.GetAIGuardrailInput, options: get_ai_guardrail.Options) !get_ai_guardrail.GetAIGuardrailOutput {
        return get_ai_guardrail.execute(self, allocator, input, options);
    }

    /// Gets and Amazon Q in Connect AI Prompt.
    pub fn getAiPrompt(self: *Self, allocator: std.mem.Allocator, input: get_ai_prompt.GetAIPromptInput, options: get_ai_prompt.Options) !get_ai_prompt.GetAIPromptOutput {
        return get_ai_prompt.execute(self, allocator, input, options);
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

    /// Returns the content association.
    ///
    /// For more information about content associations--what they are and when they
    /// are used--see [Integrate Amazon Q in Connect with step-by-step
    /// guides](https://docs.aws.amazon.com/connect/latest/adminguide/integrate-q-with-guides.html) in the *Amazon Connect Administrator Guide*.
    pub fn getContentAssociation(self: *Self, allocator: std.mem.Allocator, input: get_content_association.GetContentAssociationInput, options: get_content_association.Options) !get_content_association.GetContentAssociationOutput {
        return get_content_association.execute(self, allocator, input, options);
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

    /// Retrieves the Amazon Q in Connect message template. The message template
    /// identifier can contain an optional qualifier, for example,
    /// `<message-template-id>:<qualifier>`, which is either an actual version
    /// number or an Amazon Q Connect managed qualifier `$ACTIVE_VERSION` |
    /// `$LATEST`. If it is not supplied, then `$LATEST` is assumed implicitly.
    pub fn getMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: get_message_template.GetMessageTemplateInput, options: get_message_template.Options) !get_message_template.GetMessageTemplateOutput {
        return get_message_template.execute(self, allocator, input, options);
    }

    /// Retrieves next message on an Amazon Q in Connect session.
    pub fn getNextMessage(self: *Self, allocator: std.mem.Allocator, input: get_next_message.GetNextMessageInput, options: get_next_message.Options) !get_next_message.GetNextMessageOutput {
        return get_next_message.execute(self, allocator, input, options);
    }

    /// Retrieves the quick response.
    pub fn getQuickResponse(self: *Self, allocator: std.mem.Allocator, input: get_quick_response.GetQuickResponseInput, options: get_quick_response.Options) !get_quick_response.GetQuickResponseOutput {
        return get_quick_response.execute(self, allocator, input, options);
    }

    /// This API will be discontinued starting June 1, 2024. To receive generative
    /// responses after March 1, 2024, you will need to create a new Assistant in
    /// the Amazon Connect console and integrate the Amazon Q in Connect JavaScript
    /// library (amazon-q-connectjs) into your applications.
    ///
    /// Retrieves recommendations for the specified session. To avoid retrieving the
    /// same recommendations in subsequent calls, use
    /// [NotifyRecommendationsReceived](https://docs.aws.amazon.com/amazon-q-connect/latest/APIReference/API_NotifyRecommendationsReceived.html). This API supports long-polling behavior with the `waitTimeSeconds` parameter. Short poll is the default behavior and only returns recommendations already available. To perform a manual query against an assistant, use [QueryAssistant](https://docs.aws.amazon.com/amazon-q-connect/latest/APIReference/API_QueryAssistant.html).
    pub fn getRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_recommendations.GetRecommendationsInput, options: get_recommendations.Options) !get_recommendations.GetRecommendationsOutput {
        return get_recommendations.execute(self, allocator, input, options);
    }

    /// Retrieves information for a specified session.
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: get_session.Options) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// List AI Agent versions.
    pub fn listAiAgentVersions(self: *Self, allocator: std.mem.Allocator, input: list_ai_agent_versions.ListAIAgentVersionsInput, options: list_ai_agent_versions.Options) !list_ai_agent_versions.ListAIAgentVersionsOutput {
        return list_ai_agent_versions.execute(self, allocator, input, options);
    }

    /// Lists AI Agents.
    pub fn listAiAgents(self: *Self, allocator: std.mem.Allocator, input: list_ai_agents.ListAIAgentsInput, options: list_ai_agents.Options) !list_ai_agents.ListAIAgentsOutput {
        return list_ai_agents.execute(self, allocator, input, options);
    }

    /// Lists AI Guardrail versions.
    pub fn listAiGuardrailVersions(self: *Self, allocator: std.mem.Allocator, input: list_ai_guardrail_versions.ListAIGuardrailVersionsInput, options: list_ai_guardrail_versions.Options) !list_ai_guardrail_versions.ListAIGuardrailVersionsOutput {
        return list_ai_guardrail_versions.execute(self, allocator, input, options);
    }

    /// Lists the AI Guardrails available on the Amazon Q in Connect assistant.
    pub fn listAiGuardrails(self: *Self, allocator: std.mem.Allocator, input: list_ai_guardrails.ListAIGuardrailsInput, options: list_ai_guardrails.Options) !list_ai_guardrails.ListAIGuardrailsOutput {
        return list_ai_guardrails.execute(self, allocator, input, options);
    }

    /// Lists AI Prompt versions.
    pub fn listAiPromptVersions(self: *Self, allocator: std.mem.Allocator, input: list_ai_prompt_versions.ListAIPromptVersionsInput, options: list_ai_prompt_versions.Options) !list_ai_prompt_versions.ListAIPromptVersionsOutput {
        return list_ai_prompt_versions.execute(self, allocator, input, options);
    }

    /// Lists the AI Prompts available on the Amazon Q in Connect assistant.
    pub fn listAiPrompts(self: *Self, allocator: std.mem.Allocator, input: list_ai_prompts.ListAIPromptsInput, options: list_ai_prompts.Options) !list_ai_prompts.ListAIPromptsOutput {
        return list_ai_prompts.execute(self, allocator, input, options);
    }

    /// Lists information about assistant associations.
    pub fn listAssistantAssociations(self: *Self, allocator: std.mem.Allocator, input: list_assistant_associations.ListAssistantAssociationsInput, options: list_assistant_associations.Options) !list_assistant_associations.ListAssistantAssociationsOutput {
        return list_assistant_associations.execute(self, allocator, input, options);
    }

    /// Lists information about assistants.
    pub fn listAssistants(self: *Self, allocator: std.mem.Allocator, input: list_assistants.ListAssistantsInput, options: list_assistants.Options) !list_assistants.ListAssistantsOutput {
        return list_assistants.execute(self, allocator, input, options);
    }

    /// Lists the content associations.
    ///
    /// For more information about content associations--what they are and when they
    /// are used--see [Integrate Amazon Q in Connect with step-by-step
    /// guides](https://docs.aws.amazon.com/connect/latest/adminguide/integrate-q-with-guides.html) in the *Amazon Connect Administrator Guide*.
    pub fn listContentAssociations(self: *Self, allocator: std.mem.Allocator, input: list_content_associations.ListContentAssociationsInput, options: list_content_associations.Options) !list_content_associations.ListContentAssociationsOutput {
        return list_content_associations.execute(self, allocator, input, options);
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

    /// Lists all the available versions for the specified Amazon Q in Connect
    /// message template.
    pub fn listMessageTemplateVersions(self: *Self, allocator: std.mem.Allocator, input: list_message_template_versions.ListMessageTemplateVersionsInput, options: list_message_template_versions.Options) !list_message_template_versions.ListMessageTemplateVersionsOutput {
        return list_message_template_versions.execute(self, allocator, input, options);
    }

    /// Lists all the available Amazon Q in Connect message templates for the
    /// specified knowledge base.
    pub fn listMessageTemplates(self: *Self, allocator: std.mem.Allocator, input: list_message_templates.ListMessageTemplatesInput, options: list_message_templates.Options) !list_message_templates.ListMessageTemplatesOutput {
        return list_message_templates.execute(self, allocator, input, options);
    }

    /// Lists messages on an Amazon Q in Connect session.
    pub fn listMessages(self: *Self, allocator: std.mem.Allocator, input: list_messages.ListMessagesInput, options: list_messages.Options) !list_messages.ListMessagesOutput {
        return list_messages.execute(self, allocator, input, options);
    }

    /// Lists information about quick response.
    pub fn listQuickResponses(self: *Self, allocator: std.mem.Allocator, input: list_quick_responses.ListQuickResponsesInput, options: list_quick_responses.Options) !list_quick_responses.ListQuickResponsesOutput {
        return list_quick_responses.execute(self, allocator, input, options);
    }

    /// Retrieves AI agent execution traces for a session, providing granular
    /// visibility into agent orchestration flows, LLM interactions, and tool
    /// invocations.
    pub fn listSpans(self: *Self, allocator: std.mem.Allocator, input: list_spans.ListSpansInput, options: list_spans.Options) !list_spans.ListSpansOutput {
        return list_spans.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified recommendations from the specified assistant's queue
    /// of newly available recommendations. You can use this API in conjunction with
    /// [GetRecommendations](https://docs.aws.amazon.com/amazon-q-connect/latest/APIReference/API_GetRecommendations.html) and a `waitTimeSeconds` input for long-polling behavior and avoiding duplicate recommendations.
    pub fn notifyRecommendationsReceived(self: *Self, allocator: std.mem.Allocator, input: notify_recommendations_received.NotifyRecommendationsReceivedInput, options: notify_recommendations_received.Options) !notify_recommendations_received.NotifyRecommendationsReceivedOutput {
        return notify_recommendations_received.execute(self, allocator, input, options);
    }

    /// Provides feedback against the specified assistant for the specified target.
    /// This API only supports generative targets.
    pub fn putFeedback(self: *Self, allocator: std.mem.Allocator, input: put_feedback.PutFeedbackInput, options: put_feedback.Options) !put_feedback.PutFeedbackOutput {
        return put_feedback.execute(self, allocator, input, options);
    }

    /// This API will be discontinued starting June 1, 2024. To receive generative
    /// responses after March 1, 2024, you will need to create a new Assistant in
    /// the Amazon Connect console and integrate the Amazon Q in Connect JavaScript
    /// library (amazon-q-connectjs) into your applications.
    ///
    /// Performs a manual search against the specified assistant. To retrieve
    /// recommendations for an assistant, use
    /// [GetRecommendations](https://docs.aws.amazon.com/amazon-q-connect/latest/APIReference/API_GetRecommendations.html).
    pub fn queryAssistant(self: *Self, allocator: std.mem.Allocator, input: query_assistant.QueryAssistantInput, options: query_assistant.Options) !query_assistant.QueryAssistantOutput {
        return query_assistant.execute(self, allocator, input, options);
    }

    /// Removes the AI Agent that is set for use by default on an Amazon Q in
    /// Connect Assistant.
    pub fn removeAssistantAiAgent(self: *Self, allocator: std.mem.Allocator, input: remove_assistant_ai_agent.RemoveAssistantAIAgentInput, options: remove_assistant_ai_agent.Options) !remove_assistant_ai_agent.RemoveAssistantAIAgentOutput {
        return remove_assistant_ai_agent.execute(self, allocator, input, options);
    }

    /// Removes a URI template from a knowledge base.
    pub fn removeKnowledgeBaseTemplateUri(self: *Self, allocator: std.mem.Allocator, input: remove_knowledge_base_template_uri.RemoveKnowledgeBaseTemplateUriInput, options: remove_knowledge_base_template_uri.Options) !remove_knowledge_base_template_uri.RemoveKnowledgeBaseTemplateUriOutput {
        return remove_knowledge_base_template_uri.execute(self, allocator, input, options);
    }

    /// Renders the Amazon Q in Connect message template based on the attribute
    /// values provided and generates the message content. For any variable present
    /// in the message template, if the attribute value is neither provided in the
    /// attribute request parameter nor the default attribute of the message
    /// template, the rendered message content will keep the variable placeholder as
    /// it is and return the attribute keys that are missing.
    pub fn renderMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: render_message_template.RenderMessageTemplateInput, options: render_message_template.Options) !render_message_template.RenderMessageTemplateOutput {
        return render_message_template.execute(self, allocator, input, options);
    }

    /// Retrieves content from knowledge sources based on a query.
    pub fn retrieve(self: *Self, allocator: std.mem.Allocator, input: retrieve_.RetrieveInput, options: retrieve_.Options) !retrieve_.RetrieveOutput {
        return retrieve_.execute(self, allocator, input, options);
    }

    /// Searches for content in a specified knowledge base. Can be used to get a
    /// specific content resource by its name.
    pub fn searchContent(self: *Self, allocator: std.mem.Allocator, input: search_content.SearchContentInput, options: search_content.Options) !search_content.SearchContentOutput {
        return search_content.execute(self, allocator, input, options);
    }

    /// Searches for Amazon Q in Connect message templates in the specified
    /// knowledge base.
    pub fn searchMessageTemplates(self: *Self, allocator: std.mem.Allocator, input: search_message_templates.SearchMessageTemplatesInput, options: search_message_templates.Options) !search_message_templates.SearchMessageTemplatesOutput {
        return search_message_templates.execute(self, allocator, input, options);
    }

    /// Searches existing Amazon Q in Connect quick responses in an Amazon Q in
    /// Connect knowledge base.
    pub fn searchQuickResponses(self: *Self, allocator: std.mem.Allocator, input: search_quick_responses.SearchQuickResponsesInput, options: search_quick_responses.Options) !search_quick_responses.SearchQuickResponsesOutput {
        return search_quick_responses.execute(self, allocator, input, options);
    }

    /// Searches for sessions.
    pub fn searchSessions(self: *Self, allocator: std.mem.Allocator, input: search_sessions.SearchSessionsInput, options: search_sessions.Options) !search_sessions.SearchSessionsOutput {
        return search_sessions.execute(self, allocator, input, options);
    }

    /// Submits a message to the Amazon Q in Connect session.
    pub fn sendMessage(self: *Self, allocator: std.mem.Allocator, input: send_message.SendMessageInput, options: send_message.Options) !send_message.SendMessageOutput {
        return send_message.execute(self, allocator, input, options);
    }

    /// Get a URL to upload content to a knowledge base. To upload content, first
    /// make a PUT request to the returned URL with your file, making sure to
    /// include the required headers. Then use
    /// [CreateContent](https://docs.aws.amazon.com/amazon-q-connect/latest/APIReference/API_CreateContent.html) to finalize the content creation process or [UpdateContent](https://docs.aws.amazon.com/amazon-q-connect/latest/APIReference/API_UpdateContent.html) to modify an existing resource. You can only upload content to a knowledge base of type CUSTOM.
    pub fn startContentUpload(self: *Self, allocator: std.mem.Allocator, input: start_content_upload.StartContentUploadInput, options: start_content_upload.Options) !start_content_upload.StartContentUploadOutput {
        return start_content_upload.execute(self, allocator, input, options);
    }

    /// Start an asynchronous job to import Amazon Q in Connect resources from an
    /// uploaded source file. Before calling this API, use
    /// [StartContentUpload](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_StartContentUpload.html) to upload an asset that contains the resource data.
    ///
    /// * For importing Amazon Q in Connect quick responses, you need to upload a
    ///   csv file including the quick responses. For information about how to
    ///   format the csv file for importing quick responses, see [Import quick
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

    /// Updates an AI Agent.
    pub fn updateAiAgent(self: *Self, allocator: std.mem.Allocator, input: update_ai_agent.UpdateAIAgentInput, options: update_ai_agent.Options) !update_ai_agent.UpdateAIAgentOutput {
        return update_ai_agent.execute(self, allocator, input, options);
    }

    /// Updates an AI Guardrail.
    pub fn updateAiGuardrail(self: *Self, allocator: std.mem.Allocator, input: update_ai_guardrail.UpdateAIGuardrailInput, options: update_ai_guardrail.Options) !update_ai_guardrail.UpdateAIGuardrailOutput {
        return update_ai_guardrail.execute(self, allocator, input, options);
    }

    /// Updates an AI Prompt.
    pub fn updateAiPrompt(self: *Self, allocator: std.mem.Allocator, input: update_ai_prompt.UpdateAIPromptInput, options: update_ai_prompt.Options) !update_ai_prompt.UpdateAIPromptOutput {
        return update_ai_prompt.execute(self, allocator, input, options);
    }

    /// Updates the AI Agent that is set for use by default on an Amazon Q in
    /// Connect Assistant.
    pub fn updateAssistantAiAgent(self: *Self, allocator: std.mem.Allocator, input: update_assistant_ai_agent.UpdateAssistantAIAgentInput, options: update_assistant_ai_agent.Options) !update_assistant_ai_agent.UpdateAssistantAIAgentOutput {
        return update_assistant_ai_agent.execute(self, allocator, input, options);
    }

    /// Updates information about the content.
    pub fn updateContent(self: *Self, allocator: std.mem.Allocator, input: update_content.UpdateContentInput, options: update_content.Options) !update_content.UpdateContentOutput {
        return update_content.execute(self, allocator, input, options);
    }

    /// Updates the template URI of a knowledge base. This is only supported for
    /// knowledge bases of type EXTERNAL. Include a single variable in `${variable}`
    /// format; this interpolated by Amazon Q in Connect using ingested content. For
    /// example, if you ingest a Salesforce article, it has an `Id` value, and you
    /// can set the template URI to
    /// `https://myInstanceName.lightning.force.com/lightning/r/Knowledge__kav/*${Id}*/view`.
    pub fn updateKnowledgeBaseTemplateUri(self: *Self, allocator: std.mem.Allocator, input: update_knowledge_base_template_uri.UpdateKnowledgeBaseTemplateUriInput, options: update_knowledge_base_template_uri.Options) !update_knowledge_base_template_uri.UpdateKnowledgeBaseTemplateUriOutput {
        return update_knowledge_base_template_uri.execute(self, allocator, input, options);
    }

    /// Updates the Amazon Q in Connect message template. Partial update is
    /// supported. If any field is not supplied, it will remain unchanged for the
    /// message template that is referenced by the `$LATEST` qualifier. Any
    /// modification will only apply to the message template that is referenced by
    /// the `$LATEST` qualifier. The fields for all available versions will remain
    /// unchanged.
    pub fn updateMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: update_message_template.UpdateMessageTemplateInput, options: update_message_template.Options) !update_message_template.UpdateMessageTemplateOutput {
        return update_message_template.execute(self, allocator, input, options);
    }

    /// Updates the Amazon Q in Connect message template metadata. Note that any
    /// modification to the message template’s name, description and grouping
    /// configuration will applied to the message template pointed by the `$LATEST`
    /// qualifier and all available versions. Partial update is supported. If any
    /// field is not supplied, it will remain unchanged for the message template.
    pub fn updateMessageTemplateMetadata(self: *Self, allocator: std.mem.Allocator, input: update_message_template_metadata.UpdateMessageTemplateMetadataInput, options: update_message_template_metadata.Options) !update_message_template_metadata.UpdateMessageTemplateMetadataOutput {
        return update_message_template_metadata.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Q in Connect quick response.
    pub fn updateQuickResponse(self: *Self, allocator: std.mem.Allocator, input: update_quick_response.UpdateQuickResponseInput, options: update_quick_response.Options) !update_quick_response.UpdateQuickResponseOutput {
        return update_quick_response.execute(self, allocator, input, options);
    }

    /// Updates a session. A session is a contextual container used for generating
    /// recommendations. Amazon Connect updates the existing Amazon Q in Connect
    /// session for each contact on which Amazon Q in Connect is enabled.
    pub fn updateSession(self: *Self, allocator: std.mem.Allocator, input: update_session.UpdateSessionInput, options: update_session.Options) !update_session.UpdateSessionOutput {
        return update_session.execute(self, allocator, input, options);
    }

    /// Updates the data stored on an Amazon Q in Connect Session.
    pub fn updateSessionData(self: *Self, allocator: std.mem.Allocator, input: update_session_data.UpdateSessionDataInput, options: update_session_data.Options) !update_session_data.UpdateSessionDataOutput {
        return update_session_data.execute(self, allocator, input, options);
    }

    pub fn listAiAgentVersionsPaginator(self: *Self, params: list_ai_agent_versions.ListAIAgentVersionsInput) paginator.ListAIAgentVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAiAgentsPaginator(self: *Self, params: list_ai_agents.ListAIAgentsInput) paginator.ListAIAgentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAiGuardrailVersionsPaginator(self: *Self, params: list_ai_guardrail_versions.ListAIGuardrailVersionsInput) paginator.ListAIGuardrailVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAiGuardrailsPaginator(self: *Self, params: list_ai_guardrails.ListAIGuardrailsInput) paginator.ListAIGuardrailsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAiPromptVersionsPaginator(self: *Self, params: list_ai_prompt_versions.ListAIPromptVersionsInput) paginator.ListAIPromptVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAiPromptsPaginator(self: *Self, params: list_ai_prompts.ListAIPromptsInput) paginator.ListAIPromptsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
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

    pub fn listContentAssociationsPaginator(self: *Self, params: list_content_associations.ListContentAssociationsInput) paginator.ListContentAssociationsPaginator {
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

    pub fn listMessageTemplateVersionsPaginator(self: *Self, params: list_message_template_versions.ListMessageTemplateVersionsInput) paginator.ListMessageTemplateVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMessageTemplatesPaginator(self: *Self, params: list_message_templates.ListMessageTemplatesInput) paginator.ListMessageTemplatesPaginator {
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

    pub fn listQuickResponsesPaginator(self: *Self, params: list_quick_responses.ListQuickResponsesInput) paginator.ListQuickResponsesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSpansPaginator(self: *Self, params: list_spans.ListSpansInput) paginator.ListSpansPaginator {
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

    pub fn searchMessageTemplatesPaginator(self: *Self, params: search_message_templates.SearchMessageTemplatesInput) paginator.SearchMessageTemplatesPaginator {
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
