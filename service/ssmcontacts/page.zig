/// Incident Manager engaging a contact's contact channel.
pub const Page = struct {
    /// The ARN of the contact that Incident Manager is engaging.
    contact_arn: []const u8,

    /// The time the message was delivered to the contact channel.
    delivery_time: ?i64 = null,

    /// The ARN of the engagement that this page is part of.
    engagement_arn: []const u8,

    /// The ARN of the incident that's engaging the contact channel.
    incident_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the page to the contact channel.
    page_arn: []const u8,

    /// The time that the contact channel acknowledged engagement.
    read_time: ?i64 = null,

    /// The user that started the engagement.
    sender: []const u8,

    /// The time that Incident Manager engaged the contact channel.
    sent_time: ?i64 = null,

    pub const json_field_names = .{
        .contact_arn = "ContactArn",
        .delivery_time = "DeliveryTime",
        .engagement_arn = "EngagementArn",
        .incident_id = "IncidentId",
        .page_arn = "PageArn",
        .read_time = "ReadTime",
        .sender = "Sender",
        .sent_time = "SentTime",
    };
};
