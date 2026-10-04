const ClusteringFrequency = @import("clustering_frequency.zig").ClusteringFrequency;

/// Configuration for periodic batch evaluation clustering, specifying how often
/// clustering jobs run.
pub const ClusteringConfig = struct {
    /// The list of frequencies at which clustering batch evaluations are triggered.
    frequencies: []const ClusteringFrequency,

    pub const json_field_names = .{
        .frequencies = "frequencies",
    };
};
