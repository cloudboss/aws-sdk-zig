const ResolutionStrategy = @import("resolution_strategy.zig").ResolutionStrategy;

/// Describes the conflict resolution configuration for your data model
/// configured in your Amplify project.
pub const BackendAPIConflictResolution = struct {
    /// The strategy for conflict resolution.
    resolution_strategy: ?ResolutionStrategy,

    pub const json_field_names = .{
        .resolution_strategy = "ResolutionStrategy",
    };
};
