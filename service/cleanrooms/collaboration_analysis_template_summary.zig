/// The metadata of the analysis template within a collaboration.
pub const CollaborationAnalysisTemplateSummary = struct {
    /// The Amazon Resource Name (ARN) of the analysis template.
    arn: []const u8,

    /// The unique ARN for the analysis template’s associated collaboration.
    collaboration_arn: []const u8,

    /// A unique identifier for the collaboration that the analysis templates belong
    /// to. Currently accepts collaboration ID.
    collaboration_id: []const u8,

    /// The time that the summary of the analysis template in a collaboration was
    /// created.
    create_time: i64,

    /// The identifier used to reference members of the collaboration. Currently
    /// only supports Amazon Web Services account ID.
    creator_account_id: []const u8,

    /// The description of the analysis template.
    description: ?[]const u8 = null,

    /// The identifier of the analysis template.
    id: []const u8,

    /// Indicates if this collaboration analysis template uses synthetic data
    /// generation.
    is_synthetic_data: ?bool = null,

    /// The name of the analysis template.
    name: []const u8,

    /// The time that the summary of the analysis template in the collaboration was
    /// last updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .id = "id",
        .is_synthetic_data = "isSyntheticData",
        .name = "name",
        .update_time = "updateTime",
    };
};
