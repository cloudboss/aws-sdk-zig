const AccessScopePath = @import("access_scope_path.zig").AccessScopePath;

/// Describes the Network Access Scope content.
pub const NetworkInsightsAccessScopeContent = struct {
    /// The paths to exclude.
    exclude_paths: ?[]const AccessScopePath,

    /// The paths to match.
    match_paths: ?[]const AccessScopePath,

    /// The ID of the Network Access Scope.
    network_insights_access_scope_id: ?[]const u8,
};
