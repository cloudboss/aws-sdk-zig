const Anomaly = @import("anomaly.zig").Anomaly;
const Sequence = @import("sequence.zig").Sequence;

/// Contains information about the detected behavior.
pub const Detection = struct {
    /// The details about the anomalous activity that caused GuardDuty to generate
    /// the finding.
    anomaly: ?Anomaly = null,

    /// The details about the attack sequence.
    sequence: ?Sequence = null,

    pub const json_field_names = .{
        .anomaly = "Anomaly",
        .sequence = "Sequence",
    };
};
