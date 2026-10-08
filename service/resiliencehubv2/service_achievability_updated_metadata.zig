/// Metadata for a service achievability updated event.
pub const ServiceAchievabilityUpdatedMetadata = struct {
    /// The assessment identifier that triggered the update.
    assessment_id: ?[]const u8 = null,

    /// The updated achievability status of the availability SLO.
    availability_slo: ?[]const u8 = null,

    /// The updated achievability status of the multi-AZ RTO and RPO targets.
    multi_az_rto_rpo: ?[]const u8 = null,

    /// The updated achievability status of the multi-Region RTO and RPO targets.
    multi_region_rto_rpo: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .availability_slo = "availabilitySlo",
        .multi_az_rto_rpo = "multiAzRtoRpo",
        .multi_region_rto_rpo = "multiRegionRtoRpo",
    };
};
