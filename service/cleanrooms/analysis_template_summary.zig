/// The metadata of the analysis template.
pub const AnalysisTemplateSummary = struct {
    /// The Amazon Resource Name (ARN) of the analysis template.
    arn: []const u8,

    /// The unique ARN for the analysis template summary’s associated collaboration.
    collaboration_arn: []const u8,

    /// A unique identifier for the collaboration that the analysis template summary
    /// belongs to. Currently accepts collaboration ID.
    collaboration_id: []const u8,

    /// The time that the analysis template summary was created.
    create_time: i64,

    /// The description of the analysis template.
    description: ?[]const u8 = null,

    /// The identifier of the analysis template.
    id: []const u8,

    /// Indicates if this analysis template summary generated synthetic data.
    is_synthetic_data: ?bool = null,

    /// The Amazon Resource Name (ARN) of the member who created the analysis
    /// template.
    membership_arn: []const u8,

    /// The identifier for a membership resource.
    membership_id: []const u8,

    /// The name of the analysis template.
    name: []const u8,

    /// The time that the analysis template summary was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .is_synthetic_data = "isSyntheticData",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .update_time = "updateTime",
    };
};
