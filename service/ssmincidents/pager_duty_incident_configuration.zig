/// Details about the PagerDuty service where the response plan creates an
/// incident.
pub const PagerDutyIncidentConfiguration = struct {
    /// The ID of the PagerDuty service that the response plan associates with an
    /// incident when it
    /// launches.
    service_id: []const u8,

    pub const json_field_names = .{
        .service_id = "serviceId",
    };
};
