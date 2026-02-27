/// Incident Manager reaching out to a contact or escalation plan to engage
/// contact during an
/// incident.
pub const Engagement = struct {
    /// The ARN of the escalation plan or contact that Incident Manager is engaging.
    contact_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the engagement.
    engagement_arn: []const u8,

    /// The ARN of the incident that's engaging the contact.
    incident_id: ?[]const u8,

    /// The user that started the engagement.
    sender: []const u8,

    /// The time that the engagement began.
    start_time: ?i64,

    /// The time that the engagement ended.
    stop_time: ?i64,

    pub const json_field_names = .{
        .contact_arn = "ContactArn",
        .engagement_arn = "EngagementArn",
        .incident_id = "IncidentId",
        .sender = "Sender",
        .start_time = "StartTime",
        .stop_time = "StopTime",
    };
};
