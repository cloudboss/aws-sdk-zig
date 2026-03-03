/// The notification that informs a user of an update in Audit Manager. For
/// example, this includes the notification that's sent when a control set is
/// delegated for
/// review.
pub const Notification = struct {
    /// The identifier for the assessment.
    assessment_id: ?[]const u8 = null,

    /// The name of the related assessment.
    assessment_name: ?[]const u8 = null,

    /// The identifier for the control set.
    control_set_id: ?[]const u8 = null,

    /// Specifies the name of the control set that the notification is about.
    control_set_name: ?[]const u8 = null,

    /// The description of the notification.
    description: ?[]const u8 = null,

    /// The time when the notification was sent.
    event_time: ?i64 = null,

    /// The unique identifier for the notification.
    id: ?[]const u8 = null,

    /// The sender of the notification.
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .assessment_name = "assessmentName",
        .control_set_id = "controlSetId",
        .control_set_name = "controlSetName",
        .description = "description",
        .event_time = "eventTime",
        .id = "id",
        .source = "source",
    };
};
