/// Details about what created the incident record and when it was created.
pub const IncidentRecordSource = struct {
    /// The principal that started the incident.
    created_by: []const u8,

    /// The service principal that assumed the role specified in `createdBy`. If no
    /// service principal assumed the role this will be left blank.
    invoked_by: ?[]const u8,

    /// The resource that caused the incident to be created.
    resource_arn: ?[]const u8,

    /// The service that started the incident. This can be manually created from
    /// Incident Manager,
    /// automatically created using an Amazon CloudWatch alarm, or Amazon
    /// EventBridge
    /// event.
    source: []const u8,

    pub const json_field_names = .{
        .created_by = "createdBy",
        .invoked_by = "invokedBy",
        .resource_arn = "resourceArn",
        .source = "source",
    };
};
