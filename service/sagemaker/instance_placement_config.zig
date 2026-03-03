const PlacementSpecification = @import("placement_specification.zig").PlacementSpecification;

/// Configuration for how instances are placed and allocated within
/// UltraServers. This is only applicable for UltraServer capacity.
pub const InstancePlacementConfig = struct {
    /// If set to true, allows multiple jobs to share the same UltraServer
    /// instances. If set to false, ensures this job's instances are placed on an
    /// UltraServer exclusively, with no other jobs sharing the same UltraServer.
    /// Default is false.
    enable_multiple_jobs: ?bool = null,

    /// A list of specifications for how instances should be placed on specific
    /// UltraServers. Maximum of 10 items is supported.
    placement_specifications: ?[]const PlacementSpecification = null,

    pub const json_field_names = .{
        .enable_multiple_jobs = "EnableMultipleJobs",
        .placement_specifications = "PlacementSpecifications",
    };
};
