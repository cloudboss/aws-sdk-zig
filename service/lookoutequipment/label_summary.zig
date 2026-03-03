const LabelRating = @import("label_rating.zig").LabelRating;

/// Information about the label.
pub const LabelSummary = struct {
    /// The time at which the label was created.
    created_at: ?i64 = null,

    /// The timestamp indicating the end of the label.
    end_time: ?i64 = null,

    /// Indicates that a label pertains to a particular piece of equipment.
    equipment: ?[]const u8 = null,

    /// Indicates the type of anomaly associated with the label.
    ///
    /// Data in this field will be retained for service usage. Follow best practices
    /// for the
    /// security of your data.
    fault_code: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the label group.
    label_group_arn: ?[]const u8 = null,

    /// The name of the label group.
    label_group_name: ?[]const u8 = null,

    /// The ID of the label.
    label_id: ?[]const u8 = null,

    /// Indicates whether a labeled event represents an anomaly.
    rating: ?LabelRating = null,

    /// The timestamp indicating the start of the label.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .end_time = "EndTime",
        .equipment = "Equipment",
        .fault_code = "FaultCode",
        .label_group_arn = "LabelGroupArn",
        .label_group_name = "LabelGroupName",
        .label_id = "LabelId",
        .rating = "Rating",
        .start_time = "StartTime",
    };
};
