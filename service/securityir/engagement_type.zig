pub const EngagementType = enum {
    security_incident,
    investigation,

    pub const json_field_names = .{
        .security_incident = "SECURITY_INCIDENT",
        .investigation = "INVESTIGATION",
    };
};
