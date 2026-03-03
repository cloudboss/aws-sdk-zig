const TagQueryConfiguration = @import("tag_query_configuration.zig").TagQueryConfiguration;

/// Includes all
/// of the AppRegistry settings.
pub const AppRegistryConfiguration = struct {
    /// Includes the definition
    /// of a `tagQuery`.
    tag_query_configuration: ?TagQueryConfiguration = null,

    pub const json_field_names = .{
        .tag_query_configuration = "tagQueryConfiguration",
    };
};
