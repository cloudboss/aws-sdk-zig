/// Briefly describes a Fleet Advisor collector.
pub const CollectorShortInfoResponse = struct {
    /// The name of the Fleet Advisor collector.
    collector_name: ?[]const u8 = null,

    /// The reference ID of the Fleet Advisor collector.
    collector_referenced_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .collector_name = "CollectorName",
        .collector_referenced_id = "CollectorReferencedId",
    };
};
