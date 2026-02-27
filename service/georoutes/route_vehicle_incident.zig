const RouteVehicleIncidentSeverity = @import("route_vehicle_incident_severity.zig").RouteVehicleIncidentSeverity;
const RouteVehicleIncidentType = @import("route_vehicle_incident_type.zig").RouteVehicleIncidentType;

/// Incidents corresponding to this leg of the route.
pub const RouteVehicleIncident = struct {
    /// Brief readable description of the incident.
    description: ?[]const u8,

    /// End timestamp of the incident.
    end_time: ?[]const u8,

    /// Severity of the incident Critical - The part of the route the incident
    /// affects is unusable. Major- Major impact on the leg duration, for example
    /// stop and go Minor- Minor impact on the leg duration, for example traffic jam
    /// Low - Low on duration, for example slightly increased traffic
    severity: ?RouteVehicleIncidentSeverity,

    /// Start time of the incident.
    start_time: ?[]const u8,

    /// Type of the incident.
    type: ?RouteVehicleIncidentType,

    pub const json_field_names = .{
        .description = "Description",
        .end_time = "EndTime",
        .severity = "Severity",
        .start_time = "StartTime",
        .type = "Type",
    };
};
