const aws = @import("aws");

/// Status information about the aggregated associations.
pub const InstanceAggregatedAssociationOverview = struct {
    /// Detailed status information about the aggregated associations.
    detailed_status: ?[]const u8 = null,

    /// The number of associations for the managed nodes.
    instance_association_status_aggregated_count: ?[]const aws.map.MapEntry(i32) = null,

    pub const json_field_names = .{
        .detailed_status = "DetailedStatus",
        .instance_association_status_aggregated_count = "InstanceAssociationStatusAggregatedCount",
    };
};
