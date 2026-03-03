const Tag = @import("tag.zig").Tag;

/// Describes a Network Access Scope.
pub const NetworkInsightsAccessScope = struct {
    /// The creation date.
    created_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the Network Access Scope.
    network_insights_access_scope_arn: ?[]const u8 = null,

    /// The ID of the Network Access Scope.
    network_insights_access_scope_id: ?[]const u8 = null,

    /// The tags.
    tags: ?[]const Tag = null,

    /// The last updated date.
    updated_date: ?i64 = null,
};
