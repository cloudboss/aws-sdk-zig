const DataLakeLifecycleExpiration = @import("data_lake_lifecycle_expiration.zig").DataLakeLifecycleExpiration;
const DataLakeLifecycleTransition = @import("data_lake_lifecycle_transition.zig").DataLakeLifecycleTransition;

/// Provides lifecycle details of Amazon Security Lake object.
pub const DataLakeLifecycleConfiguration = struct {
    /// Provides data expiration details of Amazon Security Lake object.
    expiration: ?DataLakeLifecycleExpiration,

    /// Provides data storage transition details of Amazon Security Lake object.
    transitions: ?[]const DataLakeLifecycleTransition,

    pub const json_field_names = .{
        .expiration = "expiration",
        .transitions = "transitions",
    };
};
