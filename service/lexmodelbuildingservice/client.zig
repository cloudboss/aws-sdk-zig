const aws = @import("aws");
const std = @import("std");

const create_bot_version = @import("create_bot_version.zig");
const create_intent_version = @import("create_intent_version.zig");
const create_slot_type_version = @import("create_slot_type_version.zig");
const delete_bot = @import("delete_bot.zig");
const delete_bot_alias = @import("delete_bot_alias.zig");
const delete_bot_channel_association = @import("delete_bot_channel_association.zig");
const delete_bot_version = @import("delete_bot_version.zig");
const delete_intent = @import("delete_intent.zig");
const delete_intent_version = @import("delete_intent_version.zig");
const delete_slot_type = @import("delete_slot_type.zig");
const delete_slot_type_version = @import("delete_slot_type_version.zig");
const delete_utterances = @import("delete_utterances.zig");
const get_bot = @import("get_bot.zig");
const get_bot_alias = @import("get_bot_alias.zig");
const get_bot_aliases = @import("get_bot_aliases.zig");
const get_bot_channel_association = @import("get_bot_channel_association.zig");
const get_bot_channel_associations = @import("get_bot_channel_associations.zig");
const get_bot_versions = @import("get_bot_versions.zig");
const get_bots = @import("get_bots.zig");
const get_builtin_intent = @import("get_builtin_intent.zig");
const get_builtin_intents = @import("get_builtin_intents.zig");
const get_builtin_slot_types = @import("get_builtin_slot_types.zig");
const get_export = @import("get_export.zig");
const get_import = @import("get_import.zig");
const get_intent = @import("get_intent.zig");
const get_intent_versions = @import("get_intent_versions.zig");
const get_intents = @import("get_intents.zig");
const get_migration = @import("get_migration.zig");
const get_migrations = @import("get_migrations.zig");
const get_slot_type = @import("get_slot_type.zig");
const get_slot_type_versions = @import("get_slot_type_versions.zig");
const get_slot_types = @import("get_slot_types.zig");
const get_utterances_view = @import("get_utterances_view.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_bot = @import("put_bot.zig");
const put_bot_alias = @import("put_bot_alias.zig");
const put_intent = @import("put_intent.zig");
const put_slot_type = @import("put_slot_type.zig");
const start_import = @import("start_import.zig");
const start_migration = @import("start_migration.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Lex Model Building Service";

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

    /// Creates a new version of the bot based on the `$LATEST`
    /// version. If the `$LATEST` version of this resource hasn't
    /// changed since you created the last version, Amazon Lex doesn't create a new
    /// version. It returns the last created version.
    ///
    /// You can update only the `$LATEST` version of the bot.
    /// You can't update the numbered versions that you create with the
    /// `CreateBotVersion` operation.
    ///
    /// When you create the first version of a bot, Amazon Lex sets the version
    /// to 1. Subsequent versions increment by 1. For more information, see
    /// versioning-intro.
    ///
    /// This operation requires permission for the
    /// `lex:CreateBotVersion` action.
    pub fn createBotVersion(self: *Self, allocator: std.mem.Allocator, input: create_bot_version.CreateBotVersionInput, options: create_bot_version.Options) !create_bot_version.CreateBotVersionOutput {
        return create_bot_version.execute(self, allocator, input, options);
    }

    /// Creates a new version of an intent based on the
    /// `$LATEST` version of the intent. If the `$LATEST`
    /// version of this intent hasn't changed since you last updated it, Amazon Lex
    /// doesn't create a new version. It returns the last version you
    /// created.
    ///
    /// You can update only the `$LATEST` version of the
    /// intent. You can't update the numbered versions that you create with the
    /// `CreateIntentVersion` operation.
    ///
    /// When you create a version of an intent, Amazon Lex sets the version to
    /// 1. Subsequent versions increment by 1. For more information, see
    /// versioning-intro.
    ///
    /// This operation requires permissions to perform the
    /// `lex:CreateIntentVersion` action.
    pub fn createIntentVersion(self: *Self, allocator: std.mem.Allocator, input: create_intent_version.CreateIntentVersionInput, options: create_intent_version.Options) !create_intent_version.CreateIntentVersionOutput {
        return create_intent_version.execute(self, allocator, input, options);
    }

    /// Creates a new version of a slot type based on the
    /// `$LATEST` version of the specified slot type. If the
    /// `$LATEST` version of this resource has not changed since the
    /// last version that you created, Amazon Lex doesn't create a new version. It
    /// returns the last version that you created.
    ///
    /// You can update only the `$LATEST` version of a slot
    /// type. You can't update the numbered versions that you create with the
    /// `CreateSlotTypeVersion` operation.
    ///
    /// When you create a version of a slot type, Amazon Lex sets the version to
    /// 1. Subsequent versions increment by 1. For more information, see
    /// versioning-intro.
    ///
    /// This operation requires permissions for the
    /// `lex:CreateSlotTypeVersion` action.
    pub fn createSlotTypeVersion(self: *Self, allocator: std.mem.Allocator, input: create_slot_type_version.CreateSlotTypeVersionInput, options: create_slot_type_version.Options) !create_slot_type_version.CreateSlotTypeVersionOutput {
        return create_slot_type_version.execute(self, allocator, input, options);
    }

    /// Deletes all versions of the bot, including the `$LATEST`
    /// version. To delete a specific version of the bot, use the DeleteBotVersion
    /// operation. The `DeleteBot`
    /// operation doesn't immediately remove the bot schema. Instead, it is marked
    /// for deletion and removed later.
    ///
    /// Amazon Lex stores utterances indefinitely for improving the ability of
    /// your bot to respond to user inputs. These utterances are not removed when
    /// the bot is deleted. To remove the utterances, use the DeleteUtterances
    /// operation.
    ///
    /// If a bot has an alias, you can't delete it. Instead, the
    /// `DeleteBot` operation returns a
    /// `ResourceInUseException` exception that includes a reference
    /// to the alias that refers to the bot. To remove the reference to the bot,
    /// delete the alias. If you get the same exception again, delete the
    /// referring alias until the `DeleteBot` operation is
    /// successful.
    ///
    /// This operation requires permissions for the
    /// `lex:DeleteBot` action.
    pub fn deleteBot(self: *Self, allocator: std.mem.Allocator, input: delete_bot.DeleteBotInput, options: delete_bot.Options) !delete_bot.DeleteBotOutput {
        return delete_bot.execute(self, allocator, input, options);
    }

    /// Deletes an alias for the specified bot.
    ///
    /// You can't delete an alias that is used in the association between a
    /// bot and a messaging channel. If an alias is used in a channel association,
    /// the `DeleteBot` operation returns a
    /// `ResourceInUseException` exception that includes a reference
    /// to the channel association that refers to the bot. You can remove the
    /// reference to the alias by deleting the channel association. If you get the
    /// same exception again, delete the referring association until the
    /// `DeleteBotAlias` operation is successful.
    pub fn deleteBotAlias(self: *Self, allocator: std.mem.Allocator, input: delete_bot_alias.DeleteBotAliasInput, options: delete_bot_alias.Options) !delete_bot_alias.DeleteBotAliasOutput {
        return delete_bot_alias.execute(self, allocator, input, options);
    }

    /// Deletes the association between an Amazon Lex bot and a messaging
    /// platform.
    ///
    /// This operation requires permission for the
    /// `lex:DeleteBotChannelAssociation` action.
    pub fn deleteBotChannelAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_bot_channel_association.DeleteBotChannelAssociationInput, options: delete_bot_channel_association.Options) !delete_bot_channel_association.DeleteBotChannelAssociationOutput {
        return delete_bot_channel_association.execute(self, allocator, input, options);
    }

    /// Deletes a specific version of a bot. To delete all versions of a
    /// bot, use the DeleteBot operation.
    ///
    /// This operation requires permissions for the
    /// `lex:DeleteBotVersion` action.
    pub fn deleteBotVersion(self: *Self, allocator: std.mem.Allocator, input: delete_bot_version.DeleteBotVersionInput, options: delete_bot_version.Options) !delete_bot_version.DeleteBotVersionOutput {
        return delete_bot_version.execute(self, allocator, input, options);
    }

    /// Deletes all versions of the intent, including the
    /// `$LATEST` version. To delete a specific version of the
    /// intent, use the DeleteIntentVersion operation.
    ///
    /// You can delete a version of an intent only if it is not
    /// referenced. To delete an intent that is referred to in one or more bots
    /// (see how-it-works), you must remove those references
    /// first.
    ///
    /// If you get the `ResourceInUseException` exception, it
    /// provides an example reference that shows where the intent is referenced.
    /// To remove the reference to the intent, either update the bot or delete
    /// it. If you get the same exception when you attempt to delete the intent
    /// again, repeat until the intent has no references and the call to
    /// `DeleteIntent` is successful.
    ///
    /// This operation requires permission for the
    /// `lex:DeleteIntent` action.
    pub fn deleteIntent(self: *Self, allocator: std.mem.Allocator, input: delete_intent.DeleteIntentInput, options: delete_intent.Options) !delete_intent.DeleteIntentOutput {
        return delete_intent.execute(self, allocator, input, options);
    }

    /// Deletes a specific version of an intent. To delete all versions of
    /// a intent, use the DeleteIntent operation.
    ///
    /// This operation requires permissions for the
    /// `lex:DeleteIntentVersion` action.
    pub fn deleteIntentVersion(self: *Self, allocator: std.mem.Allocator, input: delete_intent_version.DeleteIntentVersionInput, options: delete_intent_version.Options) !delete_intent_version.DeleteIntentVersionOutput {
        return delete_intent_version.execute(self, allocator, input, options);
    }

    /// Deletes all versions of the slot type, including the
    /// `$LATEST` version. To delete a specific version of the slot
    /// type, use the DeleteSlotTypeVersion operation.
    ///
    /// You can delete a version of a slot type only if it is not
    /// referenced. To delete a slot type that is referred to in one or more
    /// intents, you must remove those references first.
    ///
    /// If you get the `ResourceInUseException` exception,
    /// the exception provides an example reference that shows the intent where
    /// the slot type is referenced. To remove the reference to the slot type,
    /// either update the intent or delete it. If you get the same exception
    /// when you attempt to delete the slot type again, repeat until the slot
    /// type has no references and the `DeleteSlotType` call is
    /// successful.
    ///
    /// This operation requires permission for the
    /// `lex:DeleteSlotType` action.
    pub fn deleteSlotType(self: *Self, allocator: std.mem.Allocator, input: delete_slot_type.DeleteSlotTypeInput, options: delete_slot_type.Options) !delete_slot_type.DeleteSlotTypeOutput {
        return delete_slot_type.execute(self, allocator, input, options);
    }

    /// Deletes a specific version of a slot type. To delete all versions
    /// of a slot type, use the DeleteSlotType operation.
    ///
    /// This operation requires permissions for the
    /// `lex:DeleteSlotTypeVersion` action.
    pub fn deleteSlotTypeVersion(self: *Self, allocator: std.mem.Allocator, input: delete_slot_type_version.DeleteSlotTypeVersionInput, options: delete_slot_type_version.Options) !delete_slot_type_version.DeleteSlotTypeVersionOutput {
        return delete_slot_type_version.execute(self, allocator, input, options);
    }

    /// Deletes stored utterances.
    ///
    /// Amazon Lex stores the utterances that users send to your bot. Utterances
    /// are stored for 15 days for use with the GetUtterancesView operation, and
    /// then stored indefinitely for use in improving the
    /// ability of your bot to respond to user input.
    ///
    /// Use the `DeleteUtterances` operation to manually delete
    /// stored utterances for a specific user. When you use the
    /// `DeleteUtterances` operation, utterances stored for improving
    /// your bot's ability to respond to user input are deleted immediately.
    /// Utterances stored for use with the `GetUtterancesView`
    /// operation are deleted after 15 days.
    ///
    /// This operation requires permissions for the
    /// `lex:DeleteUtterances` action.
    pub fn deleteUtterances(self: *Self, allocator: std.mem.Allocator, input: delete_utterances.DeleteUtterancesInput, options: delete_utterances.Options) !delete_utterances.DeleteUtterancesOutput {
        return delete_utterances.execute(self, allocator, input, options);
    }

    /// Returns metadata information for a specific bot. You must provide
    /// the bot name and the bot version or alias.
    ///
    /// This operation requires permissions for the
    /// `lex:GetBot` action.
    pub fn getBot(self: *Self, allocator: std.mem.Allocator, input: get_bot.GetBotInput, options: get_bot.Options) !get_bot.GetBotOutput {
        return get_bot.execute(self, allocator, input, options);
    }

    /// Returns information about an Amazon Lex bot alias. For more information
    /// about aliases, see versioning-aliases.
    ///
    /// This operation requires permissions for the
    /// `lex:GetBotAlias` action.
    pub fn getBotAlias(self: *Self, allocator: std.mem.Allocator, input: get_bot_alias.GetBotAliasInput, options: get_bot_alias.Options) !get_bot_alias.GetBotAliasOutput {
        return get_bot_alias.execute(self, allocator, input, options);
    }

    /// Returns a list of aliases for a specified Amazon Lex bot.
    ///
    /// This operation requires permissions for the
    /// `lex:GetBotAliases` action.
    pub fn getBotAliases(self: *Self, allocator: std.mem.Allocator, input: get_bot_aliases.GetBotAliasesInput, options: get_bot_aliases.Options) !get_bot_aliases.GetBotAliasesOutput {
        return get_bot_aliases.execute(self, allocator, input, options);
    }

    /// Returns information about the association between an Amazon Lex bot and
    /// a messaging platform.
    ///
    /// This operation requires permissions for the
    /// `lex:GetBotChannelAssociation` action.
    pub fn getBotChannelAssociation(self: *Self, allocator: std.mem.Allocator, input: get_bot_channel_association.GetBotChannelAssociationInput, options: get_bot_channel_association.Options) !get_bot_channel_association.GetBotChannelAssociationOutput {
        return get_bot_channel_association.execute(self, allocator, input, options);
    }

    /// Returns a list of all of the channels associated with the
    /// specified bot.
    ///
    /// The `GetBotChannelAssociations` operation requires
    /// permissions for the `lex:GetBotChannelAssociations`
    /// action.
    pub fn getBotChannelAssociations(self: *Self, allocator: std.mem.Allocator, input: get_bot_channel_associations.GetBotChannelAssociationsInput, options: get_bot_channel_associations.Options) !get_bot_channel_associations.GetBotChannelAssociationsOutput {
        return get_bot_channel_associations.execute(self, allocator, input, options);
    }

    /// Gets information about all of the versions of a bot.
    ///
    /// The `GetBotVersions` operation returns a
    /// `BotMetadata` object for each version of a bot. For example,
    /// if a bot has three numbered versions, the `GetBotVersions`
    /// operation returns four `BotMetadata` objects in the response,
    /// one for each numbered version and one for the `$LATEST`
    /// version.
    ///
    /// The `GetBotVersions` operation always returns at least
    /// one version, the `$LATEST` version.
    ///
    /// This operation requires permissions for the
    /// `lex:GetBotVersions` action.
    pub fn getBotVersions(self: *Self, allocator: std.mem.Allocator, input: get_bot_versions.GetBotVersionsInput, options: get_bot_versions.Options) !get_bot_versions.GetBotVersionsOutput {
        return get_bot_versions.execute(self, allocator, input, options);
    }

    /// Returns bot information as follows:
    ///
    /// * If you provide the `nameContains` field, the
    /// response includes information for the `$LATEST` version of
    /// all bots whose name contains the specified string.
    ///
    /// * If you don't specify the `nameContains` field, the
    /// operation returns information about the `$LATEST` version
    /// of all of your bots.
    ///
    /// This operation requires permission for the `lex:GetBots`
    /// action.
    pub fn getBots(self: *Self, allocator: std.mem.Allocator, input: get_bots.GetBotsInput, options: get_bots.Options) !get_bots.GetBotsOutput {
        return get_bots.execute(self, allocator, input, options);
    }

    /// Returns information about a built-in intent.
    ///
    /// This operation requires permission for the
    /// `lex:GetBuiltinIntent` action.
    pub fn getBuiltinIntent(self: *Self, allocator: std.mem.Allocator, input: get_builtin_intent.GetBuiltinIntentInput, options: get_builtin_intent.Options) !get_builtin_intent.GetBuiltinIntentOutput {
        return get_builtin_intent.execute(self, allocator, input, options);
    }

    /// Gets a list of built-in intents that meet the specified
    /// criteria.
    ///
    /// This operation requires permission for the
    /// `lex:GetBuiltinIntents` action.
    pub fn getBuiltinIntents(self: *Self, allocator: std.mem.Allocator, input: get_builtin_intents.GetBuiltinIntentsInput, options: get_builtin_intents.Options) !get_builtin_intents.GetBuiltinIntentsOutput {
        return get_builtin_intents.execute(self, allocator, input, options);
    }

    /// Gets a list of built-in slot types that meet the specified
    /// criteria.
    ///
    /// For a list of built-in slot types, see [Slot Type
    /// Reference](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/built-in-intent-ref/slot-type-reference) in the *Alexa Skills
    /// Kit*.
    ///
    /// This operation requires permission for the
    /// `lex:GetBuiltInSlotTypes` action.
    pub fn getBuiltinSlotTypes(self: *Self, allocator: std.mem.Allocator, input: get_builtin_slot_types.GetBuiltinSlotTypesInput, options: get_builtin_slot_types.Options) !get_builtin_slot_types.GetBuiltinSlotTypesOutput {
        return get_builtin_slot_types.execute(self, allocator, input, options);
    }

    /// Exports the contents of a Amazon Lex resource in a specified format.
    pub fn getExport(self: *Self, allocator: std.mem.Allocator, input: get_export.GetExportInput, options: get_export.Options) !get_export.GetExportOutput {
        return get_export.execute(self, allocator, input, options);
    }

    /// Gets information about an import job started with the
    /// `StartImport` operation.
    pub fn getImport(self: *Self, allocator: std.mem.Allocator, input: get_import.GetImportInput, options: get_import.Options) !get_import.GetImportOutput {
        return get_import.execute(self, allocator, input, options);
    }

    /// Returns information about an intent. In addition to the intent
    /// name, you must specify the intent version.
    ///
    /// This operation requires permissions to perform the
    /// `lex:GetIntent` action.
    pub fn getIntent(self: *Self, allocator: std.mem.Allocator, input: get_intent.GetIntentInput, options: get_intent.Options) !get_intent.GetIntentOutput {
        return get_intent.execute(self, allocator, input, options);
    }

    /// Gets information about all of the versions of an intent.
    ///
    /// The `GetIntentVersions` operation returns an
    /// `IntentMetadata` object for each version of an intent. For
    /// example, if an intent has three numbered versions, the
    /// `GetIntentVersions` operation returns four
    /// `IntentMetadata` objects in the response, one for each
    /// numbered version and one for the `$LATEST` version.
    ///
    /// The `GetIntentVersions` operation always returns at
    /// least one version, the `$LATEST` version.
    ///
    /// This operation requires permissions for the
    /// `lex:GetIntentVersions` action.
    pub fn getIntentVersions(self: *Self, allocator: std.mem.Allocator, input: get_intent_versions.GetIntentVersionsInput, options: get_intent_versions.Options) !get_intent_versions.GetIntentVersionsOutput {
        return get_intent_versions.execute(self, allocator, input, options);
    }

    /// Returns intent information as follows:
    ///
    /// * If you specify the `nameContains` field, returns the
    /// `$LATEST` version of all intents that contain the
    /// specified string.
    ///
    /// * If you don't specify the `nameContains` field,
    /// returns information about the `$LATEST` version of all
    /// intents.
    ///
    /// The operation requires permission for the
    /// `lex:GetIntents` action.
    pub fn getIntents(self: *Self, allocator: std.mem.Allocator, input: get_intents.GetIntentsInput, options: get_intents.Options) !get_intents.GetIntentsOutput {
        return get_intents.execute(self, allocator, input, options);
    }

    /// Provides details about an ongoing or complete migration from an
    /// Amazon Lex V1 bot to an Amazon Lex V2 bot. Use this operation to view the
    /// migration
    /// alerts and warnings related to the migration.
    pub fn getMigration(self: *Self, allocator: std.mem.Allocator, input: get_migration.GetMigrationInput, options: get_migration.Options) !get_migration.GetMigrationOutput {
        return get_migration.execute(self, allocator, input, options);
    }

    /// Gets a list of migrations between Amazon Lex V1 and Amazon Lex V2.
    pub fn getMigrations(self: *Self, allocator: std.mem.Allocator, input: get_migrations.GetMigrationsInput, options: get_migrations.Options) !get_migrations.GetMigrationsOutput {
        return get_migrations.execute(self, allocator, input, options);
    }

    /// Returns information about a specific version of a slot type. In
    /// addition to specifying the slot type name, you must specify the slot type
    /// version.
    ///
    /// This operation requires permissions for the
    /// `lex:GetSlotType` action.
    pub fn getSlotType(self: *Self, allocator: std.mem.Allocator, input: get_slot_type.GetSlotTypeInput, options: get_slot_type.Options) !get_slot_type.GetSlotTypeOutput {
        return get_slot_type.execute(self, allocator, input, options);
    }

    /// Gets information about all versions of a slot type.
    ///
    /// The `GetSlotTypeVersions` operation returns a
    /// `SlotTypeMetadata` object for each version of a slot type.
    /// For example, if a slot type has three numbered versions, the
    /// `GetSlotTypeVersions` operation returns four
    /// `SlotTypeMetadata` objects in the response, one for each
    /// numbered version and one for the `$LATEST` version.
    ///
    /// The `GetSlotTypeVersions` operation always returns at
    /// least one version, the `$LATEST` version.
    ///
    /// This operation requires permissions for the
    /// `lex:GetSlotTypeVersions` action.
    pub fn getSlotTypeVersions(self: *Self, allocator: std.mem.Allocator, input: get_slot_type_versions.GetSlotTypeVersionsInput, options: get_slot_type_versions.Options) !get_slot_type_versions.GetSlotTypeVersionsOutput {
        return get_slot_type_versions.execute(self, allocator, input, options);
    }

    /// Returns slot type information as follows:
    ///
    /// * If you specify the `nameContains` field, returns the
    /// `$LATEST` version of all slot types that contain the
    /// specified string.
    ///
    /// * If you don't specify the `nameContains` field,
    /// returns information about the `$LATEST` version of all slot
    /// types.
    ///
    /// The operation requires permission for the
    /// `lex:GetSlotTypes` action.
    pub fn getSlotTypes(self: *Self, allocator: std.mem.Allocator, input: get_slot_types.GetSlotTypesInput, options: get_slot_types.Options) !get_slot_types.GetSlotTypesOutput {
        return get_slot_types.execute(self, allocator, input, options);
    }

    /// Use the `GetUtterancesView` operation to get information
    /// about the utterances that your users have made to your bot. You can use
    /// this list to tune the utterances that your bot responds to.
    ///
    /// For example, say that you have created a bot to order flowers.
    /// After your users have used your bot for a while, use the
    /// `GetUtterancesView` operation to see the requests that they
    /// have made and whether they have been successful. You might find that the
    /// utterance "I want flowers" is not being recognized. You could add this
    /// utterance to the `OrderFlowers` intent so that your bot
    /// recognizes that utterance.
    ///
    /// After you publish a new version of a bot, you can get information
    /// about the old version and the new so that you can compare the performance
    /// across the two versions.
    ///
    /// Utterance statistics are generated once a day. Data is available
    /// for the last 15 days. You can request information for up to 5 versions of
    /// your bot in each request. Amazon Lex returns the most frequent utterances
    /// received by the bot in the last 15 days. The response contains information
    /// about a maximum of 100 utterances for each version.
    ///
    /// If you set `childDirected` field to true when you
    /// created your bot, if you are using slot obfuscation with one or more
    /// slots, or if you opted out of participating in improving Amazon Lex,
    /// utterances
    /// are not available.
    ///
    /// This operation requires permissions for the
    /// `lex:GetUtterancesView` action.
    pub fn getUtterancesView(self: *Self, allocator: std.mem.Allocator, input: get_utterances_view.GetUtterancesViewInput, options: get_utterances_view.Options) !get_utterances_view.GetUtterancesViewOutput {
        return get_utterances_view.execute(self, allocator, input, options);
    }

    /// Gets a list of tags associated with the specified resource. Only bots,
    /// bot aliases, and bot channels can have tags associated with them.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Lex conversational bot or replaces an existing bot.
    /// When you create or update a bot you are only required to specify a name, a
    /// locale, and whether the bot is directed toward children under age 13. You
    /// can use this to add intents later, or to remove intents from an existing
    /// bot. When you create a bot with the minimum information, the bot is
    /// created or updated but Amazon Lex returns the `` response
    /// `FAILED`. You can build the bot after you add one or more
    /// intents. For more information about Amazon Lex bots, see how-it-works.
    ///
    /// If you specify the name of an existing bot, the fields in the
    /// request replace the existing values in the `$LATEST` version of
    /// the bot. Amazon Lex removes any fields that you don't provide values for in
    /// the
    /// request, except for the `idleTTLInSeconds` and
    /// `privacySettings` fields, which are set to their default
    /// values. If you don't specify values for required fields, Amazon Lex throws
    /// an
    /// exception.
    ///
    /// This operation requires permissions for the `lex:PutBot`
    /// action. For more information, see security-iam.
    pub fn putBot(self: *Self, allocator: std.mem.Allocator, input: put_bot.PutBotInput, options: put_bot.Options) !put_bot.PutBotOutput {
        return put_bot.execute(self, allocator, input, options);
    }

    /// Creates an alias for the specified version of the bot or replaces
    /// an alias for the specified bot. To change the version of the bot that the
    /// alias points to, replace the alias. For more information about aliases,
    /// see versioning-aliases.
    ///
    /// This operation requires permissions for the
    /// `lex:PutBotAlias` action.
    pub fn putBotAlias(self: *Self, allocator: std.mem.Allocator, input: put_bot_alias.PutBotAliasInput, options: put_bot_alias.Options) !put_bot_alias.PutBotAliasOutput {
        return put_bot_alias.execute(self, allocator, input, options);
    }

    /// Creates an intent or replaces an existing intent.
    ///
    /// To define the interaction between the user and your bot, you use
    /// one or more intents. For a pizza ordering bot, for example, you would
    /// create an `OrderPizza` intent.
    ///
    /// To create an intent or replace an existing intent, you must provide
    /// the following:
    ///
    /// * Intent name. For example, `OrderPizza`.
    ///
    /// * Sample utterances. For example, "Can I order a pizza, please."
    /// and "I want to order a pizza."
    ///
    /// * Information to be gathered. You specify slot types for the
    /// information that your bot will request from the user. You can specify
    /// standard slot types, such as a date or a time, or custom slot types
    /// such as the size and crust of a pizza.
    ///
    /// * How the intent will be fulfilled. You can provide a Lambda
    /// function or configure the intent to return the intent information to
    /// the client application. If you use a Lambda function, when all of the
    /// intent information is available, Amazon Lex invokes your Lambda function.
    /// If you configure your intent to return the intent information to the
    /// client application.
    ///
    /// You can specify other optional information in the request, such
    /// as:
    ///
    /// * A confirmation prompt to ask the user to confirm an intent. For
    /// example, "Shall I order your pizza?"
    ///
    /// * A conclusion statement to send to the user after the intent has
    /// been fulfilled. For example, "I placed your pizza order."
    ///
    /// * A follow-up prompt that asks the user for additional activity.
    /// For example, asking "Do you want to order a drink with your
    /// pizza?"
    ///
    /// If you specify an existing intent name to update the intent, Amazon Lex
    /// replaces the values in the `$LATEST` version of the intent with
    /// the values in the request. Amazon Lex removes fields that you don't provide
    /// in
    /// the request. If you don't specify the required fields, Amazon Lex throws an
    /// exception. When you update the `$LATEST` version of an intent,
    /// the `status` field of any bot that uses the
    /// `$LATEST` version of the intent is set to
    /// `NOT_BUILT`.
    ///
    /// For more information, see how-it-works.
    ///
    /// This operation requires permissions for the
    /// `lex:PutIntent` action.
    pub fn putIntent(self: *Self, allocator: std.mem.Allocator, input: put_intent.PutIntentInput, options: put_intent.Options) !put_intent.PutIntentOutput {
        return put_intent.execute(self, allocator, input, options);
    }

    /// Creates a custom slot type or replaces an existing custom slot
    /// type.
    ///
    /// To create a custom slot type, specify a name for the slot type and
    /// a set of enumeration values, which are the values that a slot of this type
    /// can assume. For more information, see how-it-works.
    ///
    /// If you specify the name of an existing slot type, the fields in the
    /// request replace the existing values in the `$LATEST` version of
    /// the slot type. Amazon Lex removes the fields that you don't provide in the
    /// request. If you don't specify required fields, Amazon Lex throws an
    /// exception.
    /// When you update the `$LATEST` version of a slot type, if a bot
    /// uses the `$LATEST` version of an intent that contains the slot
    /// type, the bot's `status` field is set to
    /// `NOT_BUILT`.
    ///
    /// This operation requires permissions for the
    /// `lex:PutSlotType` action.
    pub fn putSlotType(self: *Self, allocator: std.mem.Allocator, input: put_slot_type.PutSlotTypeInput, options: put_slot_type.Options) !put_slot_type.PutSlotTypeOutput {
        return put_slot_type.execute(self, allocator, input, options);
    }

    /// Starts a job to import a resource to Amazon Lex.
    pub fn startImport(self: *Self, allocator: std.mem.Allocator, input: start_import.StartImportInput, options: start_import.Options) !start_import.StartImportOutput {
        return start_import.execute(self, allocator, input, options);
    }

    /// Starts migrating a bot from Amazon Lex V1 to Amazon Lex V2. Migrate your bot
    /// when
    /// you want to take advantage of the new features of Amazon Lex V2.
    ///
    /// For more information, see [Migrating a
    /// bot](https://docs.aws.amazon.com/lex/latest/dg/migrate.html) in the *Amazon
    /// Lex
    /// developer guide*.
    pub fn startMigration(self: *Self, allocator: std.mem.Allocator, input: start_migration.StartMigrationInput, options: start_migration.Options) !start_migration.StartMigrationOutput {
        return start_migration.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource. If a tag key
    /// already exists, the existing value is replaced with the new value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a bot, bot alias or bot channel.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn getBotAliasesPaginator(self: *Self, params: get_bot_aliases.GetBotAliasesInput) paginator.GetBotAliasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getBotChannelAssociationsPaginator(self: *Self, params: get_bot_channel_associations.GetBotChannelAssociationsInput) paginator.GetBotChannelAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getBotVersionsPaginator(self: *Self, params: get_bot_versions.GetBotVersionsInput) paginator.GetBotVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getBotsPaginator(self: *Self, params: get_bots.GetBotsInput) paginator.GetBotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getBuiltinIntentsPaginator(self: *Self, params: get_builtin_intents.GetBuiltinIntentsInput) paginator.GetBuiltinIntentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getBuiltinSlotTypesPaginator(self: *Self, params: get_builtin_slot_types.GetBuiltinSlotTypesInput) paginator.GetBuiltinSlotTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIntentVersionsPaginator(self: *Self, params: get_intent_versions.GetIntentVersionsInput) paginator.GetIntentVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIntentsPaginator(self: *Self, params: get_intents.GetIntentsInput) paginator.GetIntentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getMigrationsPaginator(self: *Self, params: get_migrations.GetMigrationsInput) paginator.GetMigrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSlotTypeVersionsPaginator(self: *Self, params: get_slot_type_versions.GetSlotTypeVersionsInput) paginator.GetSlotTypeVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSlotTypesPaginator(self: *Self, params: get_slot_types.GetSlotTypesInput) paginator.GetSlotTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
