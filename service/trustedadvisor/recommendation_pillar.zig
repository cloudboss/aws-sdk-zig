pub const RecommendationPillar = enum {
    cost_optimizing,
    performance,
    security,
    service_limits,
    fault_tolerance,
    operational_excellence,

    pub const json_field_names = .{
        .cost_optimizing = "COST_OPTIMIZING",
        .performance = "PERFORMANCE",
        .security = "SECURITY",
        .service_limits = "SERVICE_LIMITS",
        .fault_tolerance = "FAULT_TOLERANCE",
        .operational_excellence = "OPERATIONAL_EXCELLENCE",
    };
};
