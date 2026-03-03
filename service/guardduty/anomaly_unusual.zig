const aws = @import("aws");

const AnomalyObject = @import("anomaly_object.zig").AnomalyObject;

/// Contains information about the behavior of the anomaly that is new to
/// GuardDuty.
pub const AnomalyUnusual = struct {
    /// The behavior of the anomalous activity that caused GuardDuty to
    /// generate the finding.
    behavior: ?[]const aws.map.MapEntry([]const aws.map.MapEntry(AnomalyObject)) = null,

    pub const json_field_names = .{
        .behavior = "Behavior",
    };
};
