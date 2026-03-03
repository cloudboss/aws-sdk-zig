const IncrementalTrainingDataChannelOutput = @import("incremental_training_data_channel_output.zig").IncrementalTrainingDataChannelOutput;
const TrainedModelStatus = @import("trained_model_status.zig").TrainedModelStatus;

/// Provides summary information about a trained model in a collaboration.
pub const CollaborationTrainedModelSummary = struct {
    /// The collaboration ID of the collaboration that contains the trained model.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm association
    /// that is used for this trained model.
    configured_model_algorithm_association_arn: []const u8,

    /// The time at which the trained model was created.
    create_time: i64,

    /// The account ID of the member that created the trained model.
    creator_account_id: []const u8,

    /// The description of the trained model.
    description: ?[]const u8 = null,

    /// Information about the incremental training data channels used to create this
    /// version of the trained model.
    incremental_training_data_channels: ?[]const IncrementalTrainingDataChannelOutput = null,

    /// The membership ID of the member that created the trained model.
    membership_identifier: []const u8,

    /// The name of the trained model.
    name: []const u8,

    /// The status of the trained model.
    status: TrainedModelStatus,

    /// The Amazon Resource Name (ARN) of the trained model.
    trained_model_arn: []const u8,

    /// The most recent time at which the trained model was updated.
    update_time: i64,

    /// The version identifier of this trained model version.
    version_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .incremental_training_data_channels = "incrementalTrainingDataChannels",
        .membership_identifier = "membershipIdentifier",
        .name = "name",
        .status = "status",
        .trained_model_arn = "trainedModelArn",
        .update_time = "updateTime",
        .version_identifier = "versionIdentifier",
    };
};
