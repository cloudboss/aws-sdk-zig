const aws = @import("aws");
const std = @import("std");

const batch_create_custom_vocabulary_item = @import("batch_create_custom_vocabulary_item.zig");
const batch_delete_custom_vocabulary_item = @import("batch_delete_custom_vocabulary_item.zig");
const batch_update_custom_vocabulary_item = @import("batch_update_custom_vocabulary_item.zig");
const build_bot_locale = @import("build_bot_locale.zig");
const create_bot = @import("create_bot.zig");
const create_bot_alias = @import("create_bot_alias.zig");
const create_bot_locale = @import("create_bot_locale.zig");
const create_bot_replica = @import("create_bot_replica.zig");
const create_bot_version = @import("create_bot_version.zig");
const create_export = @import("create_export.zig");
const create_intent = @import("create_intent.zig");
const create_resource_policy = @import("create_resource_policy.zig");
const create_resource_policy_statement = @import("create_resource_policy_statement.zig");
const create_slot = @import("create_slot.zig");
const create_slot_type = @import("create_slot_type.zig");
const create_test_set_discrepancy_report = @import("create_test_set_discrepancy_report.zig");
const create_upload_url = @import("create_upload_url.zig");
const delete_bot = @import("delete_bot.zig");
const delete_bot_alias = @import("delete_bot_alias.zig");
const delete_bot_analyzer_recommendation = @import("delete_bot_analyzer_recommendation.zig");
const delete_bot_locale = @import("delete_bot_locale.zig");
const delete_bot_replica = @import("delete_bot_replica.zig");
const delete_bot_version = @import("delete_bot_version.zig");
const delete_custom_vocabulary = @import("delete_custom_vocabulary.zig");
const delete_export = @import("delete_export.zig");
const delete_import = @import("delete_import.zig");
const delete_intent = @import("delete_intent.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_resource_policy_statement = @import("delete_resource_policy_statement.zig");
const delete_slot = @import("delete_slot.zig");
const delete_slot_type = @import("delete_slot_type.zig");
const delete_test_set = @import("delete_test_set.zig");
const delete_utterances = @import("delete_utterances.zig");
const describe_bot = @import("describe_bot.zig");
const describe_bot_alias = @import("describe_bot_alias.zig");
const describe_bot_analyzer_recommendation = @import("describe_bot_analyzer_recommendation.zig");
const describe_bot_locale = @import("describe_bot_locale.zig");
const describe_bot_recommendation = @import("describe_bot_recommendation.zig");
const describe_bot_replica = @import("describe_bot_replica.zig");
const describe_bot_resource_generation = @import("describe_bot_resource_generation.zig");
const describe_bot_version = @import("describe_bot_version.zig");
const describe_custom_vocabulary_metadata = @import("describe_custom_vocabulary_metadata.zig");
const describe_export = @import("describe_export.zig");
const describe_import = @import("describe_import.zig");
const describe_intent = @import("describe_intent.zig");
const describe_resource_policy = @import("describe_resource_policy.zig");
const describe_slot = @import("describe_slot.zig");
const describe_slot_type = @import("describe_slot_type.zig");
const describe_test_execution = @import("describe_test_execution.zig");
const describe_test_set = @import("describe_test_set.zig");
const describe_test_set_discrepancy_report = @import("describe_test_set_discrepancy_report.zig");
const describe_test_set_generation = @import("describe_test_set_generation.zig");
const generate_bot_element = @import("generate_bot_element.zig");
const get_test_execution_artifacts_url = @import("get_test_execution_artifacts_url.zig");
const list_aggregated_utterances = @import("list_aggregated_utterances.zig");
const list_bot_alias_replicas = @import("list_bot_alias_replicas.zig");
const list_bot_aliases = @import("list_bot_aliases.zig");
const list_bot_analyzer_history = @import("list_bot_analyzer_history.zig");
const list_bot_locales = @import("list_bot_locales.zig");
const list_bot_recommendations = @import("list_bot_recommendations.zig");
const list_bot_replicas = @import("list_bot_replicas.zig");
const list_bot_resource_generations = @import("list_bot_resource_generations.zig");
const list_bot_version_replicas = @import("list_bot_version_replicas.zig");
const list_bot_versions = @import("list_bot_versions.zig");
const list_bots = @import("list_bots.zig");
const list_built_in_intents = @import("list_built_in_intents.zig");
const list_built_in_slot_types = @import("list_built_in_slot_types.zig");
const list_custom_vocabulary_items = @import("list_custom_vocabulary_items.zig");
const list_exports = @import("list_exports.zig");
const list_imports = @import("list_imports.zig");
const list_intent_metrics = @import("list_intent_metrics.zig");
const list_intent_paths = @import("list_intent_paths.zig");
const list_intent_stage_metrics = @import("list_intent_stage_metrics.zig");
const list_intents = @import("list_intents.zig");
const list_recommended_intents = @import("list_recommended_intents.zig");
const list_session_analytics_data = @import("list_session_analytics_data.zig");
const list_session_metrics = @import("list_session_metrics.zig");
const list_slot_types = @import("list_slot_types.zig");
const list_slots = @import("list_slots.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_test_execution_result_items = @import("list_test_execution_result_items.zig");
const list_test_executions = @import("list_test_executions.zig");
const list_test_set_records = @import("list_test_set_records.zig");
const list_test_sets = @import("list_test_sets.zig");
const list_utterance_analytics_data = @import("list_utterance_analytics_data.zig");
const list_utterance_metrics = @import("list_utterance_metrics.zig");
const search_associated_transcripts = @import("search_associated_transcripts.zig");
const start_bot_analyzer = @import("start_bot_analyzer.zig");
const start_bot_recommendation = @import("start_bot_recommendation.zig");
const start_bot_resource_generation = @import("start_bot_resource_generation.zig");
const start_import = @import("start_import.zig");
const start_test_execution = @import("start_test_execution.zig");
const start_test_set_generation = @import("start_test_set_generation.zig");
const stop_bot_analyzer = @import("stop_bot_analyzer.zig");
const stop_bot_recommendation = @import("stop_bot_recommendation.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_bot = @import("update_bot.zig");
const update_bot_alias = @import("update_bot_alias.zig");
const update_bot_locale = @import("update_bot_locale.zig");
const update_bot_recommendation = @import("update_bot_recommendation.zig");
const update_export = @import("update_export.zig");
const update_intent = @import("update_intent.zig");
const update_resource_policy = @import("update_resource_policy.zig");
const update_slot = @import("update_slot.zig");
const update_slot_type = @import("update_slot_type.zig");
const update_test_set = @import("update_test_set.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Lex Models V2";

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

    /// Create a batch of custom vocabulary items for a given bot locale's
    /// custom vocabulary.
    pub fn batchCreateCustomVocabularyItem(self: *Self, allocator: std.mem.Allocator, input: batch_create_custom_vocabulary_item.BatchCreateCustomVocabularyItemInput, options: CallOptions) !batch_create_custom_vocabulary_item.BatchCreateCustomVocabularyItemOutput {
        return batch_create_custom_vocabulary_item.execute(self, allocator, input, options);
    }

    /// Delete a batch of custom vocabulary items for a given bot locale's
    /// custom vocabulary.
    pub fn batchDeleteCustomVocabularyItem(self: *Self, allocator: std.mem.Allocator, input: batch_delete_custom_vocabulary_item.BatchDeleteCustomVocabularyItemInput, options: CallOptions) !batch_delete_custom_vocabulary_item.BatchDeleteCustomVocabularyItemOutput {
        return batch_delete_custom_vocabulary_item.execute(self, allocator, input, options);
    }

    /// Update a batch of custom vocabulary items for a given bot locale's custom
    /// vocabulary.
    pub fn batchUpdateCustomVocabularyItem(self: *Self, allocator: std.mem.Allocator, input: batch_update_custom_vocabulary_item.BatchUpdateCustomVocabularyItemInput, options: CallOptions) !batch_update_custom_vocabulary_item.BatchUpdateCustomVocabularyItemOutput {
        return batch_update_custom_vocabulary_item.execute(self, allocator, input, options);
    }

    /// Builds a bot, its intents, and its slot types into a specific
    /// locale. A bot can be built into multiple locales. At runtime the locale
    /// is used to choose a specific build of the bot.
    pub fn buildBotLocale(self: *Self, allocator: std.mem.Allocator, input: build_bot_locale.BuildBotLocaleInput, options: CallOptions) !build_bot_locale.BuildBotLocaleOutput {
        return build_bot_locale.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Lex conversational bot.
    pub fn createBot(self: *Self, allocator: std.mem.Allocator, input: create_bot.CreateBotInput, options: CallOptions) !create_bot.CreateBotOutput {
        return create_bot.execute(self, allocator, input, options);
    }

    /// Creates an alias for the specified version of a bot. Use an alias to
    /// enable you to change the version of a bot without updating applications
    /// that use the bot.
    ///
    /// For example, you can create an alias called "PROD" that your
    /// applications use to call the Amazon Lex bot.
    pub fn createBotAlias(self: *Self, allocator: std.mem.Allocator, input: create_bot_alias.CreateBotAliasInput, options: CallOptions) !create_bot_alias.CreateBotAliasOutput {
        return create_bot_alias.execute(self, allocator, input, options);
    }

    /// Creates a locale in the bot. The locale contains the intents and
    /// slot types that the bot uses in conversations with users in the
    /// specified language and locale. You must add a locale to a bot before
    /// you can add intents and slot types to the bot.
    pub fn createBotLocale(self: *Self, allocator: std.mem.Allocator, input: create_bot_locale.CreateBotLocaleInput, options: CallOptions) !create_bot_locale.CreateBotLocaleOutput {
        return create_bot_locale.execute(self, allocator, input, options);
    }

    /// Action to create a replication of the source bot in the secondary region.
    pub fn createBotReplica(self: *Self, allocator: std.mem.Allocator, input: create_bot_replica.CreateBotReplicaInput, options: CallOptions) !create_bot_replica.CreateBotReplicaOutput {
        return create_bot_replica.execute(self, allocator, input, options);
    }

    /// Creates an immutable version of the bot. When you create the first
    /// version of a bot, Amazon Lex sets the version number to 1. Subsequent bot
    /// versions increase
    /// in an increment of 1. The version number will always represent the total
    /// number
    /// of versions created of the bot, not the current number of versions. If a bot
    /// version
    /// is deleted, that bot version number will not be reused.
    pub fn createBotVersion(self: *Self, allocator: std.mem.Allocator, input: create_bot_version.CreateBotVersionInput, options: CallOptions) !create_bot_version.CreateBotVersionOutput {
        return create_bot_version.execute(self, allocator, input, options);
    }

    /// Creates a zip archive containing the contents of a bot or a bot
    /// locale. The archive contains a directory structure that contains JSON
    /// files that define the bot.
    ///
    /// You can create an archive that contains the complete definition of a
    /// bot, or you can specify that the archive contain only the definition of
    /// a single bot locale.
    ///
    /// For more information about exporting bots, and about the structure
    /// of the export archive, see [ Importing and
    /// exporting bots
    /// ](https://docs.aws.amazon.com/lexv2/latest/dg/importing-exporting.html)
    pub fn createExport(self: *Self, allocator: std.mem.Allocator, input: create_export.CreateExportInput, options: CallOptions) !create_export.CreateExportOutput {
        return create_export.execute(self, allocator, input, options);
    }

    /// Creates an intent.
    ///
    /// To define the interaction between the user and your bot, you define
    /// one or more intents. For example, for a pizza ordering bot you would
    /// create an `OrderPizza` intent.
    ///
    /// When you create an intent, you must provide a name. You can
    /// optionally provide the following:
    ///
    /// * Sample utterances. For example, "I want to order a pizza" and
    /// "Can I order a pizza." You can't provide utterances for built-in
    /// intents.
    ///
    /// * Information to be gathered. You specify slots for the
    /// information that you bot requests from the user. You can specify
    /// standard slot types, such as date and time, or custom slot types
    /// for your application.
    ///
    /// * How the intent is fulfilled. You can provide a Lambda function
    /// or configure the intent to return the intent information to your
    /// client application. If you use a Lambda function, Amazon Lex invokes
    /// the function when all of the intent information is
    /// available.
    ///
    /// * A confirmation prompt to send to the user to confirm an
    /// intent. For example, "Shall I order your pizza?"
    ///
    /// * A conclusion statement to send to the user after the intent is
    /// fulfilled. For example, "I ordered your pizza."
    ///
    /// * A follow-up prompt that asks the user for additional activity.
    /// For example, "Do you want a drink with your pizza?"
    pub fn createIntent(self: *Self, allocator: std.mem.Allocator, input: create_intent.CreateIntentInput, options: CallOptions) !create_intent.CreateIntentOutput {
        return create_intent.execute(self, allocator, input, options);
    }

    /// Creates a new resource policy with the specified policy
    /// statements.
    pub fn createResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: create_resource_policy.CreateResourcePolicyInput, options: CallOptions) !create_resource_policy.CreateResourcePolicyOutput {
        return create_resource_policy.execute(self, allocator, input, options);
    }

    /// Adds a new resource policy statement to a bot or bot alias. If a
    /// resource policy exists, the statement is added to the current resource
    /// policy. If a policy doesn't exist, a new policy is created.
    ///
    /// You can't create a resource policy statement that allows
    /// cross-account access.
    ///
    /// You need to add the `CreateResourcePolicy` or `UpdateResourcePolicy`
    /// action to the bot role in order to call the API.
    pub fn createResourcePolicyStatement(self: *Self, allocator: std.mem.Allocator, input: create_resource_policy_statement.CreateResourcePolicyStatementInput, options: CallOptions) !create_resource_policy_statement.CreateResourcePolicyStatementOutput {
        return create_resource_policy_statement.execute(self, allocator, input, options);
    }

    /// Creates a slot in an intent. A slot is a variable needed to fulfill
    /// an intent. For example, an `OrderPizza` intent might need
    /// slots for size, crust, and number of pizzas. For each slot, you define
    /// one or more utterances that Amazon Lex uses to elicit a response from the
    /// user.
    pub fn createSlot(self: *Self, allocator: std.mem.Allocator, input: create_slot.CreateSlotInput, options: CallOptions) !create_slot.CreateSlotOutput {
        return create_slot.execute(self, allocator, input, options);
    }

    /// Creates a custom slot type
    ///
    /// To create a custom slot type, specify a name for the slot type and
    /// a set of enumeration values, the values that a slot of this type can
    /// assume.
    pub fn createSlotType(self: *Self, allocator: std.mem.Allocator, input: create_slot_type.CreateSlotTypeInput, options: CallOptions) !create_slot_type.CreateSlotTypeOutput {
        return create_slot_type.execute(self, allocator, input, options);
    }

    /// Create a report that describes the differences between the bot and the test
    /// set.
    pub fn createTestSetDiscrepancyReport(self: *Self, allocator: std.mem.Allocator, input: create_test_set_discrepancy_report.CreateTestSetDiscrepancyReportInput, options: CallOptions) !create_test_set_discrepancy_report.CreateTestSetDiscrepancyReportOutput {
        return create_test_set_discrepancy_report.execute(self, allocator, input, options);
    }

    /// Gets a pre-signed S3 write URL that you use to upload the zip
    /// archive when importing a bot or a bot locale.
    pub fn createUploadUrl(self: *Self, allocator: std.mem.Allocator, input: create_upload_url.CreateUploadUrlInput, options: CallOptions) !create_upload_url.CreateUploadUrlOutput {
        return create_upload_url.execute(self, allocator, input, options);
    }

    /// Deletes all versions of a bot, including the `Draft`
    /// version. To delete a specific version, use the
    /// `DeleteBotVersion` operation.
    ///
    /// When you delete a bot, all of the resources contained in the bot are
    /// also deleted. Deleting a bot removes all locales, intents, slot, and
    /// slot types defined for the bot.
    ///
    /// If a bot has an alias, the `DeleteBot` operation returns
    /// a `ResourceInUseException` exception. If you want to delete
    /// the bot and the alias, set the `skipResourceInUseCheck`
    /// parameter to `true`.
    pub fn deleteBot(self: *Self, allocator: std.mem.Allocator, input: delete_bot.DeleteBotInput, options: CallOptions) !delete_bot.DeleteBotOutput {
        return delete_bot.execute(self, allocator, input, options);
    }

    /// Deletes the specified bot alias.
    pub fn deleteBotAlias(self: *Self, allocator: std.mem.Allocator, input: delete_bot_alias.DeleteBotAliasInput, options: CallOptions) !delete_bot_alias.DeleteBotAliasOutput {
        return delete_bot_alias.execute(self, allocator, input, options);
    }

    /// Permanently deletes the recommendations and analysis results for a specific
    /// bot analysis request. This operation is provided for GDPR compliance and
    /// cannot be undone.
    ///
    /// After deletion, the analysis results cannot be retrieved. The analysis
    /// request ID will still appear in the history list, but attempting to describe
    /// the recommendations will return a `ResourceNotFoundException`.
    pub fn deleteBotAnalyzerRecommendation(self: *Self, allocator: std.mem.Allocator, input: delete_bot_analyzer_recommendation.DeleteBotAnalyzerRecommendationInput, options: CallOptions) !delete_bot_analyzer_recommendation.DeleteBotAnalyzerRecommendationOutput {
        return delete_bot_analyzer_recommendation.execute(self, allocator, input, options);
    }

    /// Removes a locale from a bot.
    ///
    /// When you delete a locale, all intents, slots, and slot types defined
    /// for the locale are also deleted.
    pub fn deleteBotLocale(self: *Self, allocator: std.mem.Allocator, input: delete_bot_locale.DeleteBotLocaleInput, options: CallOptions) !delete_bot_locale.DeleteBotLocaleOutput {
        return delete_bot_locale.execute(self, allocator, input, options);
    }

    /// The action to delete the replicated bot in the secondary region.
    pub fn deleteBotReplica(self: *Self, allocator: std.mem.Allocator, input: delete_bot_replica.DeleteBotReplicaInput, options: CallOptions) !delete_bot_replica.DeleteBotReplicaOutput {
        return delete_bot_replica.execute(self, allocator, input, options);
    }

    /// Deletes a specific version of a bot. To delete all versions of a bot,
    /// use the
    /// [DeleteBot](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_DeleteBot.html) operation.
    pub fn deleteBotVersion(self: *Self, allocator: std.mem.Allocator, input: delete_bot_version.DeleteBotVersionInput, options: CallOptions) !delete_bot_version.DeleteBotVersionOutput {
        return delete_bot_version.execute(self, allocator, input, options);
    }

    /// Removes a custom vocabulary from the specified locale
    /// in the specified bot.
    pub fn deleteCustomVocabulary(self: *Self, allocator: std.mem.Allocator, input: delete_custom_vocabulary.DeleteCustomVocabularyInput, options: CallOptions) !delete_custom_vocabulary.DeleteCustomVocabularyOutput {
        return delete_custom_vocabulary.execute(self, allocator, input, options);
    }

    /// Removes a previous export and the associated files stored in an S3
    /// bucket.
    pub fn deleteExport(self: *Self, allocator: std.mem.Allocator, input: delete_export.DeleteExportInput, options: CallOptions) !delete_export.DeleteExportOutput {
        return delete_export.execute(self, allocator, input, options);
    }

    /// Removes a previous import and the associated file stored in an S3
    /// bucket.
    pub fn deleteImport(self: *Self, allocator: std.mem.Allocator, input: delete_import.DeleteImportInput, options: CallOptions) !delete_import.DeleteImportOutput {
        return delete_import.execute(self, allocator, input, options);
    }

    /// Removes the specified intent.
    ///
    /// Deleting an intent also deletes the slots associated with the
    /// intent.
    pub fn deleteIntent(self: *Self, allocator: std.mem.Allocator, input: delete_intent.DeleteIntentInput, options: CallOptions) !delete_intent.DeleteIntentOutput {
        return delete_intent.execute(self, allocator, input, options);
    }

    /// Removes an existing policy from a bot or bot alias. If the resource
    /// doesn't have a policy attached, Amazon Lex returns an exception.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a policy statement from a resource policy. If you delete the
    /// last statement from a policy, the policy is deleted. If you specify a
    /// statement ID that doesn't exist in the policy, or if the bot or bot
    /// alias doesn't have a policy attached, Amazon Lex returns an
    /// exception.
    ///
    /// You need to add the `DeleteResourcePolicy` or `UpdateResourcePolicy`
    /// action to the bot role in order to call the API.
    pub fn deleteResourcePolicyStatement(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy_statement.DeleteResourcePolicyStatementInput, options: CallOptions) !delete_resource_policy_statement.DeleteResourcePolicyStatementOutput {
        return delete_resource_policy_statement.execute(self, allocator, input, options);
    }

    /// Deletes the specified slot from an intent.
    pub fn deleteSlot(self: *Self, allocator: std.mem.Allocator, input: delete_slot.DeleteSlotInput, options: CallOptions) !delete_slot.DeleteSlotOutput {
        return delete_slot.execute(self, allocator, input, options);
    }

    /// Deletes a slot type from a bot locale.
    ///
    /// If a slot is using the slot type, Amazon Lex throws a
    /// `ResourceInUseException` exception. To avoid the
    /// exception, set the `skipResourceInUseCheck` parameter to
    /// `true`.
    pub fn deleteSlotType(self: *Self, allocator: std.mem.Allocator, input: delete_slot_type.DeleteSlotTypeInput, options: CallOptions) !delete_slot_type.DeleteSlotTypeOutput {
        return delete_slot_type.execute(self, allocator, input, options);
    }

    /// The action to delete the selected test set.
    pub fn deleteTestSet(self: *Self, allocator: std.mem.Allocator, input: delete_test_set.DeleteTestSetInput, options: CallOptions) !delete_test_set.DeleteTestSetOutput {
        return delete_test_set.execute(self, allocator, input, options);
    }

    /// Deletes stored utterances.
    ///
    /// Amazon Lex stores the utterances that users send to your bot. Utterances
    /// are stored for 15 days for use with the
    /// [ListAggregatedUtterances](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListAggregatedUtterances.html) operation, and
    /// then stored indefinitely for use in improving the ability of your bot
    /// to respond to user input..
    ///
    /// Use the `DeleteUtterances` operation to manually delete
    /// utterances for a specific session. When you use the
    /// `DeleteUtterances` operation, utterances stored for
    /// improving your bot's ability to respond to user input are deleted
    /// immediately. Utterances stored for use with the
    /// `ListAggregatedUtterances` operation are deleted after 15
    /// days.
    pub fn deleteUtterances(self: *Self, allocator: std.mem.Allocator, input: delete_utterances.DeleteUtterancesInput, options: CallOptions) !delete_utterances.DeleteUtterancesOutput {
        return delete_utterances.execute(self, allocator, input, options);
    }

    /// Provides metadata information about a bot.
    pub fn describeBot(self: *Self, allocator: std.mem.Allocator, input: describe_bot.DescribeBotInput, options: CallOptions) !describe_bot.DescribeBotOutput {
        return describe_bot.execute(self, allocator, input, options);
    }

    /// Get information about a specific bot alias.
    pub fn describeBotAlias(self: *Self, allocator: std.mem.Allocator, input: describe_bot_alias.DescribeBotAliasInput, options: CallOptions) !describe_bot_alias.DescribeBotAliasOutput {
        return describe_bot_alias.execute(self, allocator, input, options);
    }

    /// Retrieves the analysis results and recommendations for bot optimization. The
    /// analysis must be in `Available` status before recommendations can be
    /// retrieved.
    ///
    /// Recommendations are returned with pagination support. Each recommendation
    /// includes the issue location, priority level, detailed description, and
    /// proposed fix.
    pub fn describeBotAnalyzerRecommendation(self: *Self, allocator: std.mem.Allocator, input: describe_bot_analyzer_recommendation.DescribeBotAnalyzerRecommendationInput, options: CallOptions) !describe_bot_analyzer_recommendation.DescribeBotAnalyzerRecommendationOutput {
        return describe_bot_analyzer_recommendation.execute(self, allocator, input, options);
    }

    /// Describes the settings that a bot has for a specific locale.
    pub fn describeBotLocale(self: *Self, allocator: std.mem.Allocator, input: describe_bot_locale.DescribeBotLocaleInput, options: CallOptions) !describe_bot_locale.DescribeBotLocaleOutput {
        return describe_bot_locale.execute(self, allocator, input, options);
    }

    /// Provides metadata information about a bot recommendation. This
    /// information will enable you to get a description on the request inputs,
    /// to download associated transcripts after processing is complete, and to
    /// download intents and slot-types generated by the bot
    /// recommendation.
    pub fn describeBotRecommendation(self: *Self, allocator: std.mem.Allocator, input: describe_bot_recommendation.DescribeBotRecommendationInput, options: CallOptions) !describe_bot_recommendation.DescribeBotRecommendationOutput {
        return describe_bot_recommendation.execute(self, allocator, input, options);
    }

    /// Monitors the bot replication status through the UI console.
    pub fn describeBotReplica(self: *Self, allocator: std.mem.Allocator, input: describe_bot_replica.DescribeBotReplicaInput, options: CallOptions) !describe_bot_replica.DescribeBotReplicaOutput {
        return describe_bot_replica.execute(self, allocator, input, options);
    }

    /// Returns information about a request to generate a bot through natural
    /// language description, made through
    /// the `StartBotResource` API. Use the `generatedBotLocaleUrl`
    /// to retrieve the Amazon S3 object containing the bot locale configuration.
    /// You can
    /// then modify and import this configuration.
    pub fn describeBotResourceGeneration(self: *Self, allocator: std.mem.Allocator, input: describe_bot_resource_generation.DescribeBotResourceGenerationInput, options: CallOptions) !describe_bot_resource_generation.DescribeBotResourceGenerationOutput {
        return describe_bot_resource_generation.execute(self, allocator, input, options);
    }

    /// Provides metadata about a version of a bot.
    pub fn describeBotVersion(self: *Self, allocator: std.mem.Allocator, input: describe_bot_version.DescribeBotVersionInput, options: CallOptions) !describe_bot_version.DescribeBotVersionOutput {
        return describe_bot_version.execute(self, allocator, input, options);
    }

    /// Provides metadata information about a custom vocabulary.
    pub fn describeCustomVocabularyMetadata(self: *Self, allocator: std.mem.Allocator, input: describe_custom_vocabulary_metadata.DescribeCustomVocabularyMetadataInput, options: CallOptions) !describe_custom_vocabulary_metadata.DescribeCustomVocabularyMetadataOutput {
        return describe_custom_vocabulary_metadata.execute(self, allocator, input, options);
    }

    /// Gets information about a specific export.
    pub fn describeExport(self: *Self, allocator: std.mem.Allocator, input: describe_export.DescribeExportInput, options: CallOptions) !describe_export.DescribeExportOutput {
        return describe_export.execute(self, allocator, input, options);
    }

    /// Gets information about a specific import.
    pub fn describeImport(self: *Self, allocator: std.mem.Allocator, input: describe_import.DescribeImportInput, options: CallOptions) !describe_import.DescribeImportOutput {
        return describe_import.execute(self, allocator, input, options);
    }

    /// Returns metadata about an intent.
    pub fn describeIntent(self: *Self, allocator: std.mem.Allocator, input: describe_intent.DescribeIntentInput, options: CallOptions) !describe_intent.DescribeIntentOutput {
        return describe_intent.execute(self, allocator, input, options);
    }

    /// Gets the resource policy and policy revision for a bot or bot
    /// alias.
    pub fn describeResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: describe_resource_policy.DescribeResourcePolicyInput, options: CallOptions) !describe_resource_policy.DescribeResourcePolicyOutput {
        return describe_resource_policy.execute(self, allocator, input, options);
    }

    /// Gets metadata information about a slot.
    pub fn describeSlot(self: *Self, allocator: std.mem.Allocator, input: describe_slot.DescribeSlotInput, options: CallOptions) !describe_slot.DescribeSlotOutput {
        return describe_slot.execute(self, allocator, input, options);
    }

    /// Gets metadata information about a slot type.
    pub fn describeSlotType(self: *Self, allocator: std.mem.Allocator, input: describe_slot_type.DescribeSlotTypeInput, options: CallOptions) !describe_slot_type.DescribeSlotTypeOutput {
        return describe_slot_type.execute(self, allocator, input, options);
    }

    /// Gets metadata information about the test execution.
    pub fn describeTestExecution(self: *Self, allocator: std.mem.Allocator, input: describe_test_execution.DescribeTestExecutionInput, options: CallOptions) !describe_test_execution.DescribeTestExecutionOutput {
        return describe_test_execution.execute(self, allocator, input, options);
    }

    /// Gets metadata information about the test set.
    pub fn describeTestSet(self: *Self, allocator: std.mem.Allocator, input: describe_test_set.DescribeTestSetInput, options: CallOptions) !describe_test_set.DescribeTestSetOutput {
        return describe_test_set.execute(self, allocator, input, options);
    }

    /// Gets metadata information about the test set discrepancy report.
    pub fn describeTestSetDiscrepancyReport(self: *Self, allocator: std.mem.Allocator, input: describe_test_set_discrepancy_report.DescribeTestSetDiscrepancyReportInput, options: CallOptions) !describe_test_set_discrepancy_report.DescribeTestSetDiscrepancyReportOutput {
        return describe_test_set_discrepancy_report.execute(self, allocator, input, options);
    }

    /// Gets metadata information about the test set generation.
    pub fn describeTestSetGeneration(self: *Self, allocator: std.mem.Allocator, input: describe_test_set_generation.DescribeTestSetGenerationInput, options: CallOptions) !describe_test_set_generation.DescribeTestSetGenerationOutput {
        return describe_test_set_generation.execute(self, allocator, input, options);
    }

    /// Generates sample utterances for an intent.
    pub fn generateBotElement(self: *Self, allocator: std.mem.Allocator, input: generate_bot_element.GenerateBotElementInput, options: CallOptions) !generate_bot_element.GenerateBotElementOutput {
        return generate_bot_element.execute(self, allocator, input, options);
    }

    /// The pre-signed Amazon S3 URL to download the test execution result
    /// artifacts.
    pub fn getTestExecutionArtifactsUrl(self: *Self, allocator: std.mem.Allocator, input: get_test_execution_artifacts_url.GetTestExecutionArtifactsUrlInput, options: CallOptions) !get_test_execution_artifacts_url.GetTestExecutionArtifactsUrlOutput {
        return get_test_execution_artifacts_url.execute(self, allocator, input, options);
    }

    /// Provides a list of utterances that users have sent to the
    /// bot.
    ///
    /// Utterances are aggregated by the text of the utterance. For example,
    /// all instances where customers used the phrase "I want to order pizza"
    /// are aggregated into the same line in the response.
    ///
    /// You can see both detected utterances and missed utterances. A
    /// detected utterance is where the bot properly recognized the utterance
    /// and activated the associated intent. A missed utterance was not
    /// recognized by the bot and didn't activate an intent.
    ///
    /// Utterances can be aggregated for a bot alias or for a bot version,
    /// but not both at the same time.
    ///
    /// Utterances statistics are not generated under the following
    /// conditions:
    ///
    /// * The `childDirected` field was set to true when the
    /// bot was created.
    ///
    /// * You are using slot obfuscation with one or more slots.
    ///
    /// * You opted out of participating in improving Amazon Lex.
    pub fn listAggregatedUtterances(self: *Self, allocator: std.mem.Allocator, input: list_aggregated_utterances.ListAggregatedUtterancesInput, options: CallOptions) !list_aggregated_utterances.ListAggregatedUtterancesOutput {
        return list_aggregated_utterances.execute(self, allocator, input, options);
    }

    /// The action to list the replicated bots created from the source bot alias.
    pub fn listBotAliasReplicas(self: *Self, allocator: std.mem.Allocator, input: list_bot_alias_replicas.ListBotAliasReplicasInput, options: CallOptions) !list_bot_alias_replicas.ListBotAliasReplicasOutput {
        return list_bot_alias_replicas.execute(self, allocator, input, options);
    }

    /// Gets a list of aliases for the specified bot.
    pub fn listBotAliases(self: *Self, allocator: std.mem.Allocator, input: list_bot_aliases.ListBotAliasesInput, options: CallOptions) !list_bot_aliases.ListBotAliasesOutput {
        return list_bot_aliases.execute(self, allocator, input, options);
    }

    /// Retrieves a list of historical bot analysis executions for a specific bot.
    /// You can filter the results by locale and bot version.
    ///
    /// The history includes all analysis executions regardless of their status,
    /// allowing you to track past analyses and their outcomes.
    pub fn listBotAnalyzerHistory(self: *Self, allocator: std.mem.Allocator, input: list_bot_analyzer_history.ListBotAnalyzerHistoryInput, options: CallOptions) !list_bot_analyzer_history.ListBotAnalyzerHistoryOutput {
        return list_bot_analyzer_history.execute(self, allocator, input, options);
    }

    /// Gets a list of locales for the specified bot.
    pub fn listBotLocales(self: *Self, allocator: std.mem.Allocator, input: list_bot_locales.ListBotLocalesInput, options: CallOptions) !list_bot_locales.ListBotLocalesOutput {
        return list_bot_locales.execute(self, allocator, input, options);
    }

    /// Get a list of bot recommendations that meet the specified
    /// criteria.
    pub fn listBotRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_bot_recommendations.ListBotRecommendationsInput, options: CallOptions) !list_bot_recommendations.ListBotRecommendationsOutput {
        return list_bot_recommendations.execute(self, allocator, input, options);
    }

    /// The action to list the replicated bots.
    pub fn listBotReplicas(self: *Self, allocator: std.mem.Allocator, input: list_bot_replicas.ListBotReplicasInput, options: CallOptions) !list_bot_replicas.ListBotReplicasOutput {
        return list_bot_replicas.execute(self, allocator, input, options);
    }

    /// Lists the generation requests made for a bot locale.
    pub fn listBotResourceGenerations(self: *Self, allocator: std.mem.Allocator, input: list_bot_resource_generations.ListBotResourceGenerationsInput, options: CallOptions) !list_bot_resource_generations.ListBotResourceGenerationsOutput {
        return list_bot_resource_generations.execute(self, allocator, input, options);
    }

    /// Contains information about all the versions replication statuses applicable
    /// for Global Resiliency.
    pub fn listBotVersionReplicas(self: *Self, allocator: std.mem.Allocator, input: list_bot_version_replicas.ListBotVersionReplicasInput, options: CallOptions) !list_bot_version_replicas.ListBotVersionReplicasOutput {
        return list_bot_version_replicas.execute(self, allocator, input, options);
    }

    /// Gets information about all of the versions of a bot.
    ///
    /// The `ListBotVersions` operation returns a summary of each
    /// version of a bot. For example, if a bot has three numbered versions,
    /// the `ListBotVersions` operation returns for summaries, one
    /// for each numbered version and one for the `DRAFT`
    /// version.
    ///
    /// The `ListBotVersions` operation always returns at least
    /// one version, the `DRAFT` version.
    pub fn listBotVersions(self: *Self, allocator: std.mem.Allocator, input: list_bot_versions.ListBotVersionsInput, options: CallOptions) !list_bot_versions.ListBotVersionsOutput {
        return list_bot_versions.execute(self, allocator, input, options);
    }

    /// Gets a list of available bots.
    pub fn listBots(self: *Self, allocator: std.mem.Allocator, input: list_bots.ListBotsInput, options: CallOptions) !list_bots.ListBotsOutput {
        return list_bots.execute(self, allocator, input, options);
    }

    /// Gets a list of built-in intents provided by Amazon Lex that you can use
    /// in your bot.
    ///
    /// To use a built-in intent as a the base for your own intent, include
    /// the built-in intent signature in the `parentIntentSignature`
    /// parameter when you call the `CreateIntent` operation. For
    /// more information, see
    /// [CreateIntent](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_CreateIntent.html).
    pub fn listBuiltInIntents(self: *Self, allocator: std.mem.Allocator, input: list_built_in_intents.ListBuiltInIntentsInput, options: CallOptions) !list_built_in_intents.ListBuiltInIntentsOutput {
        return list_built_in_intents.execute(self, allocator, input, options);
    }

    /// Gets a list of built-in slot types that meet the specified
    /// criteria.
    pub fn listBuiltInSlotTypes(self: *Self, allocator: std.mem.Allocator, input: list_built_in_slot_types.ListBuiltInSlotTypesInput, options: CallOptions) !list_built_in_slot_types.ListBuiltInSlotTypesOutput {
        return list_built_in_slot_types.execute(self, allocator, input, options);
    }

    /// Paginated list of custom vocabulary items for a given bot locale's
    /// custom vocabulary.
    pub fn listCustomVocabularyItems(self: *Self, allocator: std.mem.Allocator, input: list_custom_vocabulary_items.ListCustomVocabularyItemsInput, options: CallOptions) !list_custom_vocabulary_items.ListCustomVocabularyItemsOutput {
        return list_custom_vocabulary_items.execute(self, allocator, input, options);
    }

    /// Lists the exports for a bot, bot locale, or custom vocabulary.
    /// Exports are kept in the list for 7 days.
    pub fn listExports(self: *Self, allocator: std.mem.Allocator, input: list_exports.ListExportsInput, options: CallOptions) !list_exports.ListExportsOutput {
        return list_exports.execute(self, allocator, input, options);
    }

    /// Lists the imports for a bot, bot locale, or custom vocabulary.
    /// Imports are kept in the list for 7 days.
    pub fn listImports(self: *Self, allocator: std.mem.Allocator, input: list_imports.ListImportsInput, options: CallOptions) !list_imports.ListImportsOutput {
        return list_imports.execute(self, allocator, input, options);
    }

    /// Retrieves summary metrics for the intents in your bot. The following fields
    /// are required:
    ///
    /// * `metrics` – A list of
    ///   [AnalyticsIntentMetric](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_AnalyticsIntentMetric.html) objects. In each object, use the `name` field to specify the metric to calculate, the `statistic` field to specify whether to calculate the `Sum`, `Average`, or `Max` number, and the `order` field to specify whether to sort the results in `Ascending` or `Descending` order.
    ///
    /// * `startDateTime` and `endDateTime` – Define a time range for which you want
    ///   to retrieve results.
    ///
    /// Of the optional fields, you can organize the results in the following ways:
    ///
    /// * Use the `filters` field to filter the results, the `groupBy` field to
    ///   specify categories by which to group the results, and the `binBy` field to
    ///   specify time intervals by which to group the results.
    ///
    /// * Use the `maxResults` field to limit the number of results to return in a
    ///   single response and the `nextToken` field to return the next batch of
    ///   results if the response does not return the full set of results.
    ///
    /// Note that an `order` field exists in both `binBy` and `metrics`. You can
    /// specify only one `order` in a given request.
    pub fn listIntentMetrics(self: *Self, allocator: std.mem.Allocator, input: list_intent_metrics.ListIntentMetricsInput, options: CallOptions) !list_intent_metrics.ListIntentMetricsOutput {
        return list_intent_metrics.execute(self, allocator, input, options);
    }

    /// Retrieves summary statistics for a path of intents that users take over
    /// sessions with your bot. The following fields are required:
    ///
    /// * `startDateTime` and `endDateTime` – Define a time range for which you want
    ///   to retrieve results.
    ///
    /// * `intentPath` – Define an order of intents for which you want to retrieve
    ///   metrics. Separate intents in the path with a forward slash. For example,
    ///   populate the `intentPath` field with `/BookCar/BookHotel` to see details
    ///   about how many times users invoked the `BookCar` and `BookHotel` intents
    ///   in that order.
    ///
    /// Use the optional `filters` field to filter the results.
    pub fn listIntentPaths(self: *Self, allocator: std.mem.Allocator, input: list_intent_paths.ListIntentPathsInput, options: CallOptions) !list_intent_paths.ListIntentPathsOutput {
        return list_intent_paths.execute(self, allocator, input, options);
    }

    /// Retrieves summary metrics for the stages within intents in your bot. The
    /// following fields are required:
    ///
    /// * `metrics` – A list of
    ///   [AnalyticsIntentStageMetric](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_AnalyticsIntentStageMetric.html) objects. In each object, use the `name` field to specify the metric to calculate, the `statistic` field to specify whether to calculate the `Sum`, `Average`, or `Max` number, and the `order` field to specify whether to sort the results in `Ascending` or `Descending` order.
    ///
    /// * `startDateTime` and `endDateTime` – Define a time range for which you want
    ///   to retrieve results.
    ///
    /// Of the optional fields, you can organize the results in the following ways:
    ///
    /// * Use the `filters` field to filter the results, the `groupBy` field to
    ///   specify categories by which to group the results, and the `binBy` field to
    ///   specify time intervals by which to group the results.
    ///
    /// * Use the `maxResults` field to limit the number of results to return in a
    ///   single response and the `nextToken` field to return the next batch of
    ///   results if the response does not return the full set of results.
    ///
    /// Note that an `order` field exists in both `binBy` and `metrics`. You can
    /// only specify one `order` in a given request.
    pub fn listIntentStageMetrics(self: *Self, allocator: std.mem.Allocator, input: list_intent_stage_metrics.ListIntentStageMetricsInput, options: CallOptions) !list_intent_stage_metrics.ListIntentStageMetricsOutput {
        return list_intent_stage_metrics.execute(self, allocator, input, options);
    }

    /// Get a list of intents that meet the specified criteria.
    pub fn listIntents(self: *Self, allocator: std.mem.Allocator, input: list_intents.ListIntentsInput, options: CallOptions) !list_intents.ListIntentsOutput {
        return list_intents.execute(self, allocator, input, options);
    }

    /// Gets a list of recommended intents provided by the bot
    /// recommendation that you can use in your bot. Intents in the
    /// response are ordered by relevance.
    pub fn listRecommendedIntents(self: *Self, allocator: std.mem.Allocator, input: list_recommended_intents.ListRecommendedIntentsInput, options: CallOptions) !list_recommended_intents.ListRecommendedIntentsOutput {
        return list_recommended_intents.execute(self, allocator, input, options);
    }

    /// Retrieves a list of metadata for individual user sessions with your bot. The
    /// `startDateTime` and `endDateTime` fields are required. These fields define a
    /// time range for which you want to retrieve results. Of the optional fields,
    /// you can organize the results in the following ways:
    ///
    /// * Use the `filters` field to filter the results and the `sortBy` field to
    ///   specify the values by which to sort the results.
    ///
    /// * Use the `maxResults` field to limit the number of results to return in a
    ///   single response and the `nextToken` field to return the next batch of
    ///   results if the response does not return the full set of results.
    pub fn listSessionAnalyticsData(self: *Self, allocator: std.mem.Allocator, input: list_session_analytics_data.ListSessionAnalyticsDataInput, options: CallOptions) !list_session_analytics_data.ListSessionAnalyticsDataOutput {
        return list_session_analytics_data.execute(self, allocator, input, options);
    }

    /// Retrieves summary metrics for the user sessions with your bot. The following
    /// fields are required:
    ///
    /// * `metrics` – A list of
    ///   [AnalyticsSessionMetric](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_AnalyticsSessionMetric.html) objects. In each object, use the `name` field to specify the metric to calculate, the `statistic` field to specify whether to calculate the `Sum`, `Average`, or `Max` number, and the `order` field to specify whether to sort the results in `Ascending` or `Descending` order.
    ///
    /// * `startDateTime` and `endDateTime` – Define a time range for which you want
    ///   to retrieve results.
    ///
    /// Of the optional fields, you can organize the results in the following ways:
    ///
    /// * Use the `filters` field to filter the results, the `groupBy` field to
    ///   specify categories by which to group the results, and the `binBy` field to
    ///   specify time intervals by which to group the results.
    ///
    /// * Use the `maxResults` field to limit the number of results to return in a
    ///   single response and the `nextToken` field to return the next batch of
    ///   results if the response does not return the full set of results.
    ///
    /// Note that an `order` field exists in both `binBy` and `metrics`. Currently,
    /// you can specify it in either field, but not in both.
    pub fn listSessionMetrics(self: *Self, allocator: std.mem.Allocator, input: list_session_metrics.ListSessionMetricsInput, options: CallOptions) !list_session_metrics.ListSessionMetricsOutput {
        return list_session_metrics.execute(self, allocator, input, options);
    }

    /// Gets a list of slot types that match the specified criteria.
    pub fn listSlotTypes(self: *Self, allocator: std.mem.Allocator, input: list_slot_types.ListSlotTypesInput, options: CallOptions) !list_slot_types.ListSlotTypesOutput {
        return list_slot_types.execute(self, allocator, input, options);
    }

    /// Gets a list of slots that match the specified criteria.
    pub fn listSlots(self: *Self, allocator: std.mem.Allocator, input: list_slots.ListSlotsInput, options: CallOptions) !list_slots.ListSlotsOutput {
        return list_slots.execute(self, allocator, input, options);
    }

    /// Gets a list of tags associated with a resource. Only bots, bot
    /// aliases, and bot channels can have tags associated with them.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Gets a list of test execution result items.
    pub fn listTestExecutionResultItems(self: *Self, allocator: std.mem.Allocator, input: list_test_execution_result_items.ListTestExecutionResultItemsInput, options: CallOptions) !list_test_execution_result_items.ListTestExecutionResultItemsOutput {
        return list_test_execution_result_items.execute(self, allocator, input, options);
    }

    /// The list of test set executions.
    pub fn listTestExecutions(self: *Self, allocator: std.mem.Allocator, input: list_test_executions.ListTestExecutionsInput, options: CallOptions) !list_test_executions.ListTestExecutionsOutput {
        return list_test_executions.execute(self, allocator, input, options);
    }

    /// The list of test set records.
    pub fn listTestSetRecords(self: *Self, allocator: std.mem.Allocator, input: list_test_set_records.ListTestSetRecordsInput, options: CallOptions) !list_test_set_records.ListTestSetRecordsOutput {
        return list_test_set_records.execute(self, allocator, input, options);
    }

    /// The list of the test sets
    pub fn listTestSets(self: *Self, allocator: std.mem.Allocator, input: list_test_sets.ListTestSetsInput, options: CallOptions) !list_test_sets.ListTestSetsOutput {
        return list_test_sets.execute(self, allocator, input, options);
    }

    /// To use this API operation, your IAM role must have permissions to
    /// perform the
    /// [ListAggregatedUtterances](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListAggregatedUtterances.html) operation, which provides access to
    /// utterance-related analytics. See [Viewing utterance
    /// statistics](https://docs.aws.amazon.com/lexv2/latest/dg/monitoring-utterances.html) for the IAM policy to apply to the IAM role.
    ///
    /// Retrieves a list of metadata for individual user utterances to your bot. The
    /// following fields are required:
    ///
    /// * `startDateTime` and `endDateTime` – Define a time range for which you want
    ///   to retrieve results.
    ///
    /// Of the optional fields, you can organize the results in the following ways:
    ///
    /// * Use the `filters` field to filter the results and the `sortBy` field to
    ///   specify the values by which to sort the results.
    ///
    /// * Use the `maxResults` field to limit the number of results to return in a
    ///   single response and the `nextToken` field to return the next batch of
    ///   results if the response does not return the full set of results.
    pub fn listUtteranceAnalyticsData(self: *Self, allocator: std.mem.Allocator, input: list_utterance_analytics_data.ListUtteranceAnalyticsDataInput, options: CallOptions) !list_utterance_analytics_data.ListUtteranceAnalyticsDataOutput {
        return list_utterance_analytics_data.execute(self, allocator, input, options);
    }

    /// To use this API operation, your IAM role must have permissions to
    /// perform the
    /// [ListAggregatedUtterances](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListAggregatedUtterances.html) operation, which provides access to
    /// utterance-related analytics. See [Viewing utterance
    /// statistics](https://docs.aws.amazon.com/lexv2/latest/dg/monitoring-utterances.html) for the IAM policy to apply to the IAM role.
    ///
    /// Retrieves summary metrics for the utterances in your bot. The following
    /// fields are required:
    ///
    /// * `metrics` – A list of
    ///   [AnalyticsUtteranceMetric](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_AnalyticsUtteranceMetric.html) objects. In each object, use the `name` field to specify the metric to calculate, the `statistic` field to specify whether to calculate the `Sum`, `Average`, or `Max` number, and the `order` field to specify whether to sort the results in `Ascending` or `Descending` order.
    ///
    /// * `startDateTime` and `endDateTime` – Define a time range for which you want
    ///   to retrieve results.
    ///
    /// Of the optional fields, you can organize the results in the following ways:
    ///
    /// * Use the `filters` field to filter the results, the `groupBy` field to
    ///   specify categories by which to group the results, and the `binBy` field to
    ///   specify time intervals by which to group the results.
    ///
    /// * Use the `maxResults` field to limit the number of results to return in a
    ///   single response and the `nextToken` field to return the next batch of
    ///   results if the response does not return the full set of results.
    ///
    /// Note that an `order` field exists in both `binBy` and `metrics`. Currently,
    /// you can specify it in either field, but not in both.
    pub fn listUtteranceMetrics(self: *Self, allocator: std.mem.Allocator, input: list_utterance_metrics.ListUtteranceMetricsInput, options: CallOptions) !list_utterance_metrics.ListUtteranceMetricsOutput {
        return list_utterance_metrics.execute(self, allocator, input, options);
    }

    /// Search for associated transcripts that meet the specified
    /// criteria.
    pub fn searchAssociatedTranscripts(self: *Self, allocator: std.mem.Allocator, input: search_associated_transcripts.SearchAssociatedTranscriptsInput, options: CallOptions) !search_associated_transcripts.SearchAssociatedTranscriptsOutput {
        return search_associated_transcripts.execute(self, allocator, input, options);
    }

    /// Initiates an asynchronous analysis of your bot configuration using
    /// AI-powered analysis to identify potential issues and recommend improvements
    /// based on AWS best practices.
    ///
    /// The analysis examines your bot's configuration, including intents,
    /// utterances, slots, and conversation flows, to provide actionable
    /// recommendations for optimization.
    pub fn startBotAnalyzer(self: *Self, allocator: std.mem.Allocator, input: start_bot_analyzer.StartBotAnalyzerInput, options: CallOptions) !start_bot_analyzer.StartBotAnalyzerOutput {
        return start_bot_analyzer.execute(self, allocator, input, options);
    }

    /// Use this to provide your transcript data, and to start the bot
    /// recommendation process.
    pub fn startBotRecommendation(self: *Self, allocator: std.mem.Allocator, input: start_bot_recommendation.StartBotRecommendationInput, options: CallOptions) !start_bot_recommendation.StartBotRecommendationOutput {
        return start_bot_recommendation.execute(self, allocator, input, options);
    }

    /// Starts a request for the descriptive bot builder to generate a bot locale
    /// configuration
    /// based on the prompt you provide it. After you make this call, use the
    /// `DescribeBotResourceGeneration`
    /// operation to check on the status of the generation and for the
    /// `generatedBotLocaleUrl` when the
    /// generation is complete. Use that value to retrieve the Amazon S3 object
    /// containing the bot locale configuration. You can
    /// then modify and import this configuration.
    pub fn startBotResourceGeneration(self: *Self, allocator: std.mem.Allocator, input: start_bot_resource_generation.StartBotResourceGenerationInput, options: CallOptions) !start_bot_resource_generation.StartBotResourceGenerationOutput {
        return start_bot_resource_generation.execute(self, allocator, input, options);
    }

    /// Starts importing a bot, bot locale, or custom vocabulary from a zip
    /// archive that you uploaded to an S3 bucket.
    pub fn startImport(self: *Self, allocator: std.mem.Allocator, input: start_import.StartImportInput, options: CallOptions) !start_import.StartImportOutput {
        return start_import.execute(self, allocator, input, options);
    }

    /// The action to start test set execution.
    pub fn startTestExecution(self: *Self, allocator: std.mem.Allocator, input: start_test_execution.StartTestExecutionInput, options: CallOptions) !start_test_execution.StartTestExecutionOutput {
        return start_test_execution.execute(self, allocator, input, options);
    }

    /// The action to start the generation of test set.
    pub fn startTestSetGeneration(self: *Self, allocator: std.mem.Allocator, input: start_test_set_generation.StartTestSetGenerationInput, options: CallOptions) !start_test_set_generation.StartTestSetGenerationOutput {
        return start_test_set_generation.execute(self, allocator, input, options);
    }

    /// Cancels an ongoing bot analysis execution. Once stopped, the analysis cannot
    /// be resumed and no recommendations will be generated.
    pub fn stopBotAnalyzer(self: *Self, allocator: std.mem.Allocator, input: stop_bot_analyzer.StopBotAnalyzerInput, options: CallOptions) !stop_bot_analyzer.StopBotAnalyzerOutput {
        return stop_bot_analyzer.execute(self, allocator, input, options);
    }

    /// Stop an already running Bot Recommendation request.
    pub fn stopBotRecommendation(self: *Self, allocator: std.mem.Allocator, input: stop_bot_recommendation.StopBotRecommendationInput, options: CallOptions) !stop_bot_recommendation.StopBotRecommendationOutput {
        return stop_bot_recommendation.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource. If a tag key
    /// already exists, the existing value is replaced with the new
    /// value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a bot, bot alias, or bot channel.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing bot.
    pub fn updateBot(self: *Self, allocator: std.mem.Allocator, input: update_bot.UpdateBotInput, options: CallOptions) !update_bot.UpdateBotOutput {
        return update_bot.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing bot alias.
    pub fn updateBotAlias(self: *Self, allocator: std.mem.Allocator, input: update_bot_alias.UpdateBotAliasInput, options: CallOptions) !update_bot_alias.UpdateBotAliasOutput {
        return update_bot_alias.execute(self, allocator, input, options);
    }

    /// Updates the settings that a bot has for a specific locale.
    pub fn updateBotLocale(self: *Self, allocator: std.mem.Allocator, input: update_bot_locale.UpdateBotLocaleInput, options: CallOptions) !update_bot_locale.UpdateBotLocaleOutput {
        return update_bot_locale.execute(self, allocator, input, options);
    }

    /// Updates an existing bot recommendation request.
    pub fn updateBotRecommendation(self: *Self, allocator: std.mem.Allocator, input: update_bot_recommendation.UpdateBotRecommendationInput, options: CallOptions) !update_bot_recommendation.UpdateBotRecommendationOutput {
        return update_bot_recommendation.execute(self, allocator, input, options);
    }

    /// Updates the password used to protect an export zip archive.
    ///
    /// The password is not required. If you don't supply a password, Amazon Lex
    /// generates a zip file that is not protected by a password. This is the
    /// archive that is available at the pre-signed S3 URL provided by the
    /// [DescribeExport](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_DescribeExport.html) operation.
    pub fn updateExport(self: *Self, allocator: std.mem.Allocator, input: update_export.UpdateExportInput, options: CallOptions) !update_export.UpdateExportOutput {
        return update_export.execute(self, allocator, input, options);
    }

    /// Updates the settings for an intent.
    pub fn updateIntent(self: *Self, allocator: std.mem.Allocator, input: update_intent.UpdateIntentInput, options: CallOptions) !update_intent.UpdateIntentOutput {
        return update_intent.execute(self, allocator, input, options);
    }

    /// Replaces the existing resource policy for a bot or bot alias with a
    /// new one. If the policy doesn't exist, Amazon Lex returns an
    /// exception.
    pub fn updateResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: update_resource_policy.UpdateResourcePolicyInput, options: CallOptions) !update_resource_policy.UpdateResourcePolicyOutput {
        return update_resource_policy.execute(self, allocator, input, options);
    }

    /// Updates the settings for a slot.
    pub fn updateSlot(self: *Self, allocator: std.mem.Allocator, input: update_slot.UpdateSlotInput, options: CallOptions) !update_slot.UpdateSlotOutput {
        return update_slot.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing slot type.
    pub fn updateSlotType(self: *Self, allocator: std.mem.Allocator, input: update_slot_type.UpdateSlotTypeInput, options: CallOptions) !update_slot_type.UpdateSlotTypeOutput {
        return update_slot_type.execute(self, allocator, input, options);
    }

    /// The action to update the test set.
    pub fn updateTestSet(self: *Self, allocator: std.mem.Allocator, input: update_test_set.UpdateTestSetInput, options: CallOptions) !update_test_set.UpdateTestSetOutput {
        return update_test_set.execute(self, allocator, input, options);
    }

    pub fn describeBotAnalyzerRecommendationPaginator(self: *Self, params: describe_bot_analyzer_recommendation.DescribeBotAnalyzerRecommendationInput) paginator.DescribeBotAnalyzerRecommendationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAggregatedUtterancesPaginator(self: *Self, params: list_aggregated_utterances.ListAggregatedUtterancesInput) paginator.ListAggregatedUtterancesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBotAliasReplicasPaginator(self: *Self, params: list_bot_alias_replicas.ListBotAliasReplicasInput) paginator.ListBotAliasReplicasPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBotAliasesPaginator(self: *Self, params: list_bot_aliases.ListBotAliasesInput) paginator.ListBotAliasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBotAnalyzerHistoryPaginator(self: *Self, params: list_bot_analyzer_history.ListBotAnalyzerHistoryInput) paginator.ListBotAnalyzerHistoryPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBotLocalesPaginator(self: *Self, params: list_bot_locales.ListBotLocalesInput) paginator.ListBotLocalesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBotRecommendationsPaginator(self: *Self, params: list_bot_recommendations.ListBotRecommendationsInput) paginator.ListBotRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBotResourceGenerationsPaginator(self: *Self, params: list_bot_resource_generations.ListBotResourceGenerationsInput) paginator.ListBotResourceGenerationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBotVersionReplicasPaginator(self: *Self, params: list_bot_version_replicas.ListBotVersionReplicasInput) paginator.ListBotVersionReplicasPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBotVersionsPaginator(self: *Self, params: list_bot_versions.ListBotVersionsInput) paginator.ListBotVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBotsPaginator(self: *Self, params: list_bots.ListBotsInput) paginator.ListBotsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBuiltInIntentsPaginator(self: *Self, params: list_built_in_intents.ListBuiltInIntentsInput) paginator.ListBuiltInIntentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBuiltInSlotTypesPaginator(self: *Self, params: list_built_in_slot_types.ListBuiltInSlotTypesInput) paginator.ListBuiltInSlotTypesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCustomVocabularyItemsPaginator(self: *Self, params: list_custom_vocabulary_items.ListCustomVocabularyItemsInput) paginator.ListCustomVocabularyItemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listExportsPaginator(self: *Self, params: list_exports.ListExportsInput) paginator.ListExportsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImportsPaginator(self: *Self, params: list_imports.ListImportsInput) paginator.ListImportsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIntentMetricsPaginator(self: *Self, params: list_intent_metrics.ListIntentMetricsInput) paginator.ListIntentMetricsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIntentStageMetricsPaginator(self: *Self, params: list_intent_stage_metrics.ListIntentStageMetricsInput) paginator.ListIntentStageMetricsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIntentsPaginator(self: *Self, params: list_intents.ListIntentsInput) paginator.ListIntentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecommendedIntentsPaginator(self: *Self, params: list_recommended_intents.ListRecommendedIntentsInput) paginator.ListRecommendedIntentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSessionAnalyticsDataPaginator(self: *Self, params: list_session_analytics_data.ListSessionAnalyticsDataInput) paginator.ListSessionAnalyticsDataPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSessionMetricsPaginator(self: *Self, params: list_session_metrics.ListSessionMetricsInput) paginator.ListSessionMetricsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSlotTypesPaginator(self: *Self, params: list_slot_types.ListSlotTypesInput) paginator.ListSlotTypesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSlotsPaginator(self: *Self, params: list_slots.ListSlotsInput) paginator.ListSlotsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestExecutionResultItemsPaginator(self: *Self, params: list_test_execution_result_items.ListTestExecutionResultItemsInput) paginator.ListTestExecutionResultItemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestExecutionsPaginator(self: *Self, params: list_test_executions.ListTestExecutionsInput) paginator.ListTestExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestSetRecordsPaginator(self: *Self, params: list_test_set_records.ListTestSetRecordsInput) paginator.ListTestSetRecordsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestSetsPaginator(self: *Self, params: list_test_sets.ListTestSetsInput) paginator.ListTestSetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUtteranceAnalyticsDataPaginator(self: *Self, params: list_utterance_analytics_data.ListUtteranceAnalyticsDataInput) paginator.ListUtteranceAnalyticsDataPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUtteranceMetricsPaginator(self: *Self, params: list_utterance_metrics.ListUtteranceMetricsInput) paginator.ListUtteranceMetricsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilBotAliasAvailable(self: *Self, params: describe_bot_alias.DescribeBotAliasInput) aws.waiter.WaiterError!void {
        var w = waiters.BotAliasAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilBotAvailable(self: *Self, params: describe_bot.DescribeBotInput) aws.waiter.WaiterError!void {
        var w = waiters.BotAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilBotExportCompleted(self: *Self, params: describe_export.DescribeExportInput) aws.waiter.WaiterError!void {
        var w = waiters.BotExportCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilBotImportCompleted(self: *Self, params: describe_import.DescribeImportInput) aws.waiter.WaiterError!void {
        var w = waiters.BotImportCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilBotLocaleBuilt(self: *Self, params: describe_bot_locale.DescribeBotLocaleInput) aws.waiter.WaiterError!void {
        var w = waiters.BotLocaleBuiltWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilBotLocaleCreated(self: *Self, params: describe_bot_locale.DescribeBotLocaleInput) aws.waiter.WaiterError!void {
        var w = waiters.BotLocaleCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilBotLocaleExpressTestingAvailable(self: *Self, params: describe_bot_locale.DescribeBotLocaleInput) aws.waiter.WaiterError!void {
        var w = waiters.BotLocaleExpressTestingAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilBotVersionAvailable(self: *Self, params: describe_bot_version.DescribeBotVersionInput) aws.waiter.WaiterError!void {
        var w = waiters.BotVersionAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
