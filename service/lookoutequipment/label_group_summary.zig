/// Contains information about the label group.
pub const LabelGroupSummary = struct {
    /// The time at which the label group was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the label group.
    label_group_arn: ?[]const u8 = null,

    /// The name of the label group.
    label_group_name: ?[]const u8 = null,

    /// The time at which the label group was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .label_group_arn = "LabelGroupArn",
        .label_group_name = "LabelGroupName",
        .updated_at = "UpdatedAt",
    };
};
