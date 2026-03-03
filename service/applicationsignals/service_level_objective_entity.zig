/// A structure that contains identifying information for a service level
/// objective entity.
pub const ServiceLevelObjectiveEntity = struct {
    /// The ARN of the service level objective. The SLO must be provided with ARN
    /// for cross-account access.
    slo_arn: ?[]const u8 = null,

    /// The name of the service level objective.
    slo_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .slo_arn = "SloArn",
        .slo_name = "SloName",
    };
};
