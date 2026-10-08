const RouteTransitIncidentEffect = @import("route_transit_incident_effect.zig").RouteTransitIncidentEffect;
const RouteTransitIncidentType = @import("route_transit_incident_type.zig").RouteTransitIncidentType;

/// An incident describes disruptions on the transit route.
pub const RouteTransitIncident = struct {
    /// A human readable description of the incident.
    description: ?[]const u8 = null,

    /// The effect of the incident on the transit service.
    effect: RouteTransitIncidentEffect,

    /// The end time of the incident.
    end_time: ?[]const u8 = null,

    /// The start time of the incident.
    start_time: ?[]const u8 = null,

    /// Type of the incident.
    type: RouteTransitIncidentType,

    /// URL to the original incident published at the agency website.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .effect = "Effect",
        .end_time = "EndTime",
        .start_time = "StartTime",
        .type = "Type",
        .url = "Url",
    };
};
