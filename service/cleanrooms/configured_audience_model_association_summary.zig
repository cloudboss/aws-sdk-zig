/// A summary of the configured audience model association.
pub const ConfiguredAudienceModelAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the configured audience model association.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the collaboration that contains the
    /// configured audience model association.
    collaboration_arn: []const u8,

    /// A unique identifier of the collaboration that configured audience model is
    /// associated with.
    collaboration_id: []const u8,

    /// The Amazon Resource Name (ARN) of the configured audience model that was
    /// used for this configured audience model association.
    configured_audience_model_arn: []const u8,

    /// The time at which the configured audience model association was created.
    create_time: i64,

    /// The description of the configured audience model association.
    description: ?[]const u8 = null,

    /// A unique identifier of the configured audience model association.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the membership that contains the
    /// configured audience model association.
    membership_arn: []const u8,

    /// A unique identifier of the membership that contains the configured audience
    /// model association.
    membership_id: []const u8,

    /// The name of the configured audience model association.
    name: []const u8,

    /// The most recent time at which the configured audience model association was
    /// updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .update_time = "updateTime",
    };
};
