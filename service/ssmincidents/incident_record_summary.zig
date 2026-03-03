const IncidentRecordSource = @import("incident_record_source.zig").IncidentRecordSource;
const IncidentRecordStatus = @import("incident_record_status.zig").IncidentRecordStatus;

/// Details describing an incident record.
pub const IncidentRecordSummary = struct {
    /// The Amazon Resource Name (ARN) of the incident.
    arn: []const u8,

    /// The timestamp for when the incident was created.
    creation_time: i64,

    /// Defines the impact to customers and applications.
    impact: i32,

    /// What caused Incident Manager to create the incident.
    incident_record_source: IncidentRecordSource,

    /// The timestamp for when the incident was resolved.
    resolved_time: ?i64 = null,

    /// The current status of the incident.
    status: IncidentRecordStatus,

    /// The title of the incident. This value is either provided by the response
    /// plan or
    /// overwritten on creation.
    title: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .impact = "impact",
        .incident_record_source = "incidentRecordSource",
        .resolved_time = "resolvedTime",
        .status = "status",
        .title = "title",
    };
};
