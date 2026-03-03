/// A summary of the configured audience model association in the collaboration.
pub const CollaborationConfiguredAudienceModelAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the configured audience model association.
    arn: []const u8,

    /// The unique ARN for the configured audience model's associated collaboration.
    collaboration_arn: []const u8,

    /// A unique identifier for the collaboration that the configured audience model
    /// associations belong to. Accepts collaboration ID.
    collaboration_id: []const u8,

    /// The time at which the configured audience model association was created.
    create_time: i64,

    /// The identifier used to reference members of the collaboration. Only supports
    /// Amazon Web Services account ID.
    creator_account_id: []const u8,

    /// The description of the configured audience model association.
    description: ?[]const u8 = null,

    /// The identifier of the configured audience model association.
    id: []const u8,

    /// The name of the configured audience model association.
    name: []const u8,

    /// The most recent time at which the configured audience model association was
    /// updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .id = "id",
        .name = "name",
        .update_time = "updateTime",
    };
};
