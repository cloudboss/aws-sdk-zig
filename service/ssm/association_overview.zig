const aws = @import("aws");

/// Information about the association.
pub const AssociationOverview = struct {
    /// Returns the number of targets for the association status. For example, if
    /// you created an
    /// association with two managed nodes, and one of them was successful, this
    /// would return the count
    /// of managed nodes by status.
    association_status_aggregated_count: ?[]const aws.map.MapEntry(i32),

    /// A detailed status of the association.
    detailed_status: ?[]const u8,

    /// The status of the association. Status can be: Pending, Success, or Failed.
    status: ?[]const u8,

    pub const json_field_names = .{
        .association_status_aggregated_count = "AssociationStatusAggregatedCount",
        .detailed_status = "DetailedStatus",
        .status = "Status",
    };
};
