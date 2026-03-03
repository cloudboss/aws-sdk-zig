const aws = @import("aws");
const std = @import("std");

const create_encoder_configuration = @import("create_encoder_configuration.zig");
const create_ingest_configuration = @import("create_ingest_configuration.zig");
const create_participant_token = @import("create_participant_token.zig");
const create_stage = @import("create_stage.zig");
const create_storage_configuration = @import("create_storage_configuration.zig");
const delete_encoder_configuration = @import("delete_encoder_configuration.zig");
const delete_ingest_configuration = @import("delete_ingest_configuration.zig");
const delete_public_key = @import("delete_public_key.zig");
const delete_stage = @import("delete_stage.zig");
const delete_storage_configuration = @import("delete_storage_configuration.zig");
const disconnect_participant = @import("disconnect_participant.zig");
const get_composition = @import("get_composition.zig");
const get_encoder_configuration = @import("get_encoder_configuration.zig");
const get_ingest_configuration = @import("get_ingest_configuration.zig");
const get_participant = @import("get_participant.zig");
const get_public_key = @import("get_public_key.zig");
const get_stage = @import("get_stage.zig");
const get_stage_session = @import("get_stage_session.zig");
const get_storage_configuration = @import("get_storage_configuration.zig");
const import_public_key = @import("import_public_key.zig");
const list_compositions = @import("list_compositions.zig");
const list_encoder_configurations = @import("list_encoder_configurations.zig");
const list_ingest_configurations = @import("list_ingest_configurations.zig");
const list_participant_events = @import("list_participant_events.zig");
const list_participant_replicas = @import("list_participant_replicas.zig");
const list_participants = @import("list_participants.zig");
const list_public_keys = @import("list_public_keys.zig");
const list_stage_sessions = @import("list_stage_sessions.zig");
const list_stages = @import("list_stages.zig");
const list_storage_configurations = @import("list_storage_configurations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_composition = @import("start_composition.zig");
const start_participant_replication = @import("start_participant_replication.zig");
const stop_composition = @import("stop_composition.zig");
const stop_participant_replication = @import("stop_participant_replication.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_ingest_configuration = @import("update_ingest_configuration.zig");
const update_stage = @import("update_stage.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IVS RealTime";

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

    /// Creates an EncoderConfiguration object.
    pub fn createEncoderConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_encoder_configuration.CreateEncoderConfigurationInput, options: create_encoder_configuration.Options) !create_encoder_configuration.CreateEncoderConfigurationOutput {
        return create_encoder_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new IngestConfiguration resource, used to specify the ingest
    /// protocol for a stage.
    pub fn createIngestConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_ingest_configuration.CreateIngestConfigurationInput, options: create_ingest_configuration.Options) !create_ingest_configuration.CreateIngestConfigurationOutput {
        return create_ingest_configuration.execute(self, allocator, input, options);
    }

    /// Creates an additional token for a specified stage. This can be done after
    /// stage creation
    /// or when tokens expire. Tokens always are scoped to the stage for which they
    /// are
    /// created.
    ///
    /// Encryption keys are owned by Amazon IVS and never used directly by your
    /// application.
    pub fn createParticipantToken(self: *Self, allocator: std.mem.Allocator, input: create_participant_token.CreateParticipantTokenInput, options: create_participant_token.Options) !create_participant_token.CreateParticipantTokenOutput {
        return create_participant_token.execute(self, allocator, input, options);
    }

    /// Creates a new stage (and optionally participant tokens).
    pub fn createStage(self: *Self, allocator: std.mem.Allocator, input: create_stage.CreateStageInput, options: create_stage.Options) !create_stage.CreateStageOutput {
        return create_stage.execute(self, allocator, input, options);
    }

    /// Creates a new storage configuration, used to enable recording to Amazon S3.
    /// When a StorageConfiguration is created, IVS will modify the S3 bucketPolicy
    /// of the provided bucket.
    /// This will ensure that IVS has sufficient permissions to write content to the
    /// provided bucket.
    pub fn createStorageConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_storage_configuration.CreateStorageConfigurationInput, options: create_storage_configuration.Options) !create_storage_configuration.CreateStorageConfigurationOutput {
        return create_storage_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an EncoderConfiguration resource. Ensures that no Compositions are
    /// using this
    /// template; otherwise, returns an error.
    pub fn deleteEncoderConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_encoder_configuration.DeleteEncoderConfigurationInput, options: delete_encoder_configuration.Options) !delete_encoder_configuration.DeleteEncoderConfigurationOutput {
        return delete_encoder_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a specified IngestConfiguration, so it can no longer be used to
    /// broadcast. An IngestConfiguration cannot be deleted if the publisher is
    /// actively streaming to a stage, unless `force` is set to `true`.
    pub fn deleteIngestConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_ingest_configuration.DeleteIngestConfigurationInput, options: delete_ingest_configuration.Options) !delete_ingest_configuration.DeleteIngestConfigurationOutput {
        return delete_ingest_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified public key used to sign stage participant tokens.
    /// This invalidates future participant tokens generated using the key pair’s
    /// private key.
    pub fn deletePublicKey(self: *Self, allocator: std.mem.Allocator, input: delete_public_key.DeletePublicKeyInput, options: delete_public_key.Options) !delete_public_key.DeletePublicKeyOutput {
        return delete_public_key.execute(self, allocator, input, options);
    }

    /// Shuts down and deletes the specified stage (disconnecting all participants).
    /// This operation also
    /// removes the `stageArn` from the associated IngestConfiguration, if there are
    /// participants
    /// using the IngestConfiguration to publish to the stage.
    pub fn deleteStage(self: *Self, allocator: std.mem.Allocator, input: delete_stage.DeleteStageInput, options: delete_stage.Options) !delete_stage.DeleteStageOutput {
        return delete_stage.execute(self, allocator, input, options);
    }

    /// Deletes the storage configuration for the specified ARN.
    ///
    /// If you try to delete a storage configuration that is used by a Composition,
    /// you will get an error (409 ConflictException).
    /// To avoid this, for all Compositions that reference the storage
    /// configuration, first use StopComposition and wait for it to complete,
    /// then use DeleteStorageConfiguration.
    pub fn deleteStorageConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_storage_configuration.DeleteStorageConfigurationInput, options: delete_storage_configuration.Options) !delete_storage_configuration.DeleteStorageConfigurationOutput {
        return delete_storage_configuration.execute(self, allocator, input, options);
    }

    /// Disconnects a specified participant from a specified stage. If the
    /// participant is publishing using
    /// an IngestConfiguration, DisconnectParticipant also updates the `stageArn`
    /// in the IngestConfiguration to be an empty string.
    pub fn disconnectParticipant(self: *Self, allocator: std.mem.Allocator, input: disconnect_participant.DisconnectParticipantInput, options: disconnect_participant.Options) !disconnect_participant.DisconnectParticipantOutput {
        return disconnect_participant.execute(self, allocator, input, options);
    }

    /// Get information about the specified Composition resource.
    pub fn getComposition(self: *Self, allocator: std.mem.Allocator, input: get_composition.GetCompositionInput, options: get_composition.Options) !get_composition.GetCompositionOutput {
        return get_composition.execute(self, allocator, input, options);
    }

    /// Gets information about the specified EncoderConfiguration resource.
    pub fn getEncoderConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_encoder_configuration.GetEncoderConfigurationInput, options: get_encoder_configuration.Options) !get_encoder_configuration.GetEncoderConfigurationOutput {
        return get_encoder_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about the specified IngestConfiguration.
    pub fn getIngestConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_ingest_configuration.GetIngestConfigurationInput, options: get_ingest_configuration.Options) !get_ingest_configuration.GetIngestConfigurationOutput {
        return get_ingest_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about the specified participant token.
    pub fn getParticipant(self: *Self, allocator: std.mem.Allocator, input: get_participant.GetParticipantInput, options: get_participant.Options) !get_participant.GetParticipantOutput {
        return get_participant.execute(self, allocator, input, options);
    }

    /// Gets information for the specified public key.
    pub fn getPublicKey(self: *Self, allocator: std.mem.Allocator, input: get_public_key.GetPublicKeyInput, options: get_public_key.Options) !get_public_key.GetPublicKeyOutput {
        return get_public_key.execute(self, allocator, input, options);
    }

    /// Gets information for the specified stage.
    pub fn getStage(self: *Self, allocator: std.mem.Allocator, input: get_stage.GetStageInput, options: get_stage.Options) !get_stage.GetStageOutput {
        return get_stage.execute(self, allocator, input, options);
    }

    /// Gets information for the specified stage session.
    pub fn getStageSession(self: *Self, allocator: std.mem.Allocator, input: get_stage_session.GetStageSessionInput, options: get_stage_session.Options) !get_stage_session.GetStageSessionOutput {
        return get_stage_session.execute(self, allocator, input, options);
    }

    /// Gets the storage configuration for the specified ARN.
    pub fn getStorageConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_storage_configuration.GetStorageConfigurationInput, options: get_storage_configuration.Options) !get_storage_configuration.GetStorageConfigurationOutput {
        return get_storage_configuration.execute(self, allocator, input, options);
    }

    /// Import a public key to be used for signing stage participant tokens.
    pub fn importPublicKey(self: *Self, allocator: std.mem.Allocator, input: import_public_key.ImportPublicKeyInput, options: import_public_key.Options) !import_public_key.ImportPublicKeyOutput {
        return import_public_key.execute(self, allocator, input, options);
    }

    /// Gets summary information about all Compositions in your account, in the AWS
    /// region
    /// where the API request is processed.
    pub fn listCompositions(self: *Self, allocator: std.mem.Allocator, input: list_compositions.ListCompositionsInput, options: list_compositions.Options) !list_compositions.ListCompositionsOutput {
        return list_compositions.execute(self, allocator, input, options);
    }

    /// Gets summary information about all EncoderConfigurations in your account, in
    /// the AWS
    /// region where the API request is processed.
    pub fn listEncoderConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_encoder_configurations.ListEncoderConfigurationsInput, options: list_encoder_configurations.Options) !list_encoder_configurations.ListEncoderConfigurationsOutput {
        return list_encoder_configurations.execute(self, allocator, input, options);
    }

    /// Lists all IngestConfigurations in your account, in the AWS region where the
    /// API request is processed.
    pub fn listIngestConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_ingest_configurations.ListIngestConfigurationsInput, options: list_ingest_configurations.Options) !list_ingest_configurations.ListIngestConfigurationsOutput {
        return list_ingest_configurations.execute(self, allocator, input, options);
    }

    /// Lists events for a specified participant that occurred during a specified
    /// stage
    /// session.
    pub fn listParticipantEvents(self: *Self, allocator: std.mem.Allocator, input: list_participant_events.ListParticipantEventsInput, options: list_participant_events.Options) !list_participant_events.ListParticipantEventsOutput {
        return list_participant_events.execute(self, allocator, input, options);
    }

    /// Lists all the replicas for a participant from a source stage.
    pub fn listParticipantReplicas(self: *Self, allocator: std.mem.Allocator, input: list_participant_replicas.ListParticipantReplicasInput, options: list_participant_replicas.Options) !list_participant_replicas.ListParticipantReplicasOutput {
        return list_participant_replicas.execute(self, allocator, input, options);
    }

    /// Lists all participants in a specified stage session.
    pub fn listParticipants(self: *Self, allocator: std.mem.Allocator, input: list_participants.ListParticipantsInput, options: list_participants.Options) !list_participants.ListParticipantsOutput {
        return list_participants.execute(self, allocator, input, options);
    }

    /// Gets summary information about all public keys in your account, in the AWS
    /// region where the API request is processed.
    pub fn listPublicKeys(self: *Self, allocator: std.mem.Allocator, input: list_public_keys.ListPublicKeysInput, options: list_public_keys.Options) !list_public_keys.ListPublicKeysOutput {
        return list_public_keys.execute(self, allocator, input, options);
    }

    /// Gets all sessions for a specified stage.
    pub fn listStageSessions(self: *Self, allocator: std.mem.Allocator, input: list_stage_sessions.ListStageSessionsInput, options: list_stage_sessions.Options) !list_stage_sessions.ListStageSessionsOutput {
        return list_stage_sessions.execute(self, allocator, input, options);
    }

    /// Gets summary information about all stages in your account, in the AWS region
    /// where the
    /// API request is processed.
    pub fn listStages(self: *Self, allocator: std.mem.Allocator, input: list_stages.ListStagesInput, options: list_stages.Options) !list_stages.ListStagesOutput {
        return list_stages.execute(self, allocator, input, options);
    }

    /// Gets summary information about all storage configurations in your account,
    /// in the AWS region where the API request is processed.
    pub fn listStorageConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_storage_configurations.ListStorageConfigurationsInput, options: list_storage_configurations.Options) !list_storage_configurations.ListStorageConfigurationsOutput {
        return list_storage_configurations.execute(self, allocator, input, options);
    }

    /// Gets information about AWS tags for the specified ARN.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts a Composition from a stage based on the configuration provided in the
    /// request.
    ///
    /// A Composition is an ephemeral resource that exists after this operation
    /// returns
    /// successfully. Composition stops and the resource is deleted:
    ///
    /// * When StopComposition is called.
    ///
    /// * After a 1-minute timeout, when all participants are disconnected from the
    /// stage.
    ///
    /// * After a 1-minute timeout, if there are no participants in the stage when
    /// StartComposition is called.
    ///
    /// * When broadcasting to the IVS channel fails and all retries are exhausted.
    ///
    /// * When broadcasting is disconnected and all attempts to reconnect are
    /// exhausted.
    pub fn startComposition(self: *Self, allocator: std.mem.Allocator, input: start_composition.StartCompositionInput, options: start_composition.Options) !start_composition.StartCompositionOutput {
        return start_composition.execute(self, allocator, input, options);
    }

    /// Starts replicating a publishing participant from a source stage to a
    /// destination stage.
    pub fn startParticipantReplication(self: *Self, allocator: std.mem.Allocator, input: start_participant_replication.StartParticipantReplicationInput, options: start_participant_replication.Options) !start_participant_replication.StartParticipantReplicationOutput {
        return start_participant_replication.execute(self, allocator, input, options);
    }

    /// Stops and deletes a Composition resource. Any broadcast from the Composition
    /// resource
    /// is stopped.
    pub fn stopComposition(self: *Self, allocator: std.mem.Allocator, input: stop_composition.StopCompositionInput, options: stop_composition.Options) !stop_composition.StopCompositionOutput {
        return stop_composition.execute(self, allocator, input, options);
    }

    /// Stops a replicated participant session.
    pub fn stopParticipantReplication(self: *Self, allocator: std.mem.Allocator, input: stop_participant_replication.StopParticipantReplicationInput, options: stop_participant_replication.Options) !stop_participant_replication.StopParticipantReplicationOutput {
        return stop_participant_replication.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for the AWS resource with the specified ARN.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the resource with the specified ARN.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a specified IngestConfiguration. Only the stage ARN attached to the
    /// IngestConfiguration can be updated. An IngestConfiguration that is active
    /// cannot be updated.
    pub fn updateIngestConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_ingest_configuration.UpdateIngestConfigurationInput, options: update_ingest_configuration.Options) !update_ingest_configuration.UpdateIngestConfigurationOutput {
        return update_ingest_configuration.execute(self, allocator, input, options);
    }

    /// Updates a stage’s configuration.
    pub fn updateStage(self: *Self, allocator: std.mem.Allocator, input: update_stage.UpdateStageInput, options: update_stage.Options) !update_stage.UpdateStageOutput {
        return update_stage.execute(self, allocator, input, options);
    }

    pub fn listCompositionsPaginator(self: *Self, params: list_compositions.ListCompositionsInput) paginator.ListCompositionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEncoderConfigurationsPaginator(self: *Self, params: list_encoder_configurations.ListEncoderConfigurationsInput) paginator.ListEncoderConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIngestConfigurationsPaginator(self: *Self, params: list_ingest_configurations.ListIngestConfigurationsInput) paginator.ListIngestConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listParticipantEventsPaginator(self: *Self, params: list_participant_events.ListParticipantEventsInput) paginator.ListParticipantEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listParticipantReplicasPaginator(self: *Self, params: list_participant_replicas.ListParticipantReplicasInput) paginator.ListParticipantReplicasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listParticipantsPaginator(self: *Self, params: list_participants.ListParticipantsInput) paginator.ListParticipantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPublicKeysPaginator(self: *Self, params: list_public_keys.ListPublicKeysInput) paginator.ListPublicKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStageSessionsPaginator(self: *Self, params: list_stage_sessions.ListStageSessionsInput) paginator.ListStageSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStagesPaginator(self: *Self, params: list_stages.ListStagesInput) paginator.ListStagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStorageConfigurationsPaginator(self: *Self, params: list_storage_configurations.ListStorageConfigurationsInput) paginator.ListStorageConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
