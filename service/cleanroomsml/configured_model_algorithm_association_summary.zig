/// Provides summary information about the configured model algorithm
/// association.
pub const ConfiguredModelAlgorithmAssociationSummary = struct {
    /// The collaboration ID of the collaboration that contains the configured model
    /// algorithm association.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm that is
    /// being associated.
    configured_model_algorithm_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm
    /// association.
    configured_model_algorithm_association_arn: []const u8,

    /// The time at which the configured model algorithm association was created.
    create_time: i64,

    /// The description of the configured model algorithm association.
    description: ?[]const u8 = null,

    /// The membership ID of the member that created the configured model algorithm
    /// association.
    membership_identifier: []const u8,

    /// The name of the configured model algorithm association.
    name: []const u8,

    /// The most recent time at which the configured model algorithm association was
    /// updated.
    update_time: i64,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_arn = "configuredModelAlgorithmArn",
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
        .create_time = "createTime",
        .description = "description",
        .membership_identifier = "membershipIdentifier",
        .name = "name",
        .update_time = "updateTime",
    };
};
