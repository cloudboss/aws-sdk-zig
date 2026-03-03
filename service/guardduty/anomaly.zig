const aws = @import("aws");

const AnomalyObject = @import("anomaly_object.zig").AnomalyObject;
const AnomalyUnusual = @import("anomaly_unusual.zig").AnomalyUnusual;

/// Contains information about the anomalies.
pub const Anomaly = struct {
    /// Information about the types of profiles.
    profiles: ?[]const aws.map.MapEntry([]const aws.map.MapEntry([]const AnomalyObject)) = null,

    /// Information about the behavior of the anomalies.
    unusual: ?AnomalyUnusual = null,

    pub const json_field_names = .{
        .profiles = "Profiles",
        .unusual = "Unusual",
    };
};
