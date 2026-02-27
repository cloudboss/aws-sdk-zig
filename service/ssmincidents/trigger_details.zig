/// Details about what caused the incident to be created in Incident Manager.
pub const TriggerDetails = struct {
    /// Raw data passed from either Amazon EventBridge, Amazon CloudWatch, or
    /// Incident Manager when an incident is created.
    raw_data: ?[]const u8,

    /// Identifies the service that sourced the event. All events sourced from
    /// within Amazon Web Services begin with "`aws.`" Customer-generated events can
    /// have any value here,
    /// as long as it doesn't begin with "`aws.`" We recommend the use of Java
    /// package-name
    /// style reverse domain-name strings.
    source: []const u8,

    /// The timestamp for when the incident was detected.
    timestamp: i64,

    /// The Amazon Resource Name (ARN) of the source that detected the incident.
    trigger_arn: ?[]const u8,

    pub const json_field_names = .{
        .raw_data = "rawData",
        .source = "source",
        .timestamp = "timestamp",
        .trigger_arn = "triggerArn",
    };
};
