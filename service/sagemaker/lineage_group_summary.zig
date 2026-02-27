/// Lists a summary of the properties of a lineage group. A lineage group
/// provides a group of shareable lineage entity resources.
pub const LineageGroupSummary = struct {
    /// The creation time of the lineage group summary.
    creation_time: ?i64,

    /// The display name of the lineage group summary.
    display_name: ?[]const u8,

    /// The last modified time of the lineage group summary.
    last_modified_time: ?i64,

    /// The Amazon Resource Name (ARN) of the lineage group resource.
    lineage_group_arn: ?[]const u8,

    /// The name or Amazon Resource Name (ARN) of the lineage group.
    lineage_group_name: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .display_name = "DisplayName",
        .last_modified_time = "LastModifiedTime",
        .lineage_group_arn = "LineageGroupArn",
        .lineage_group_name = "LineageGroupName",
    };
};
