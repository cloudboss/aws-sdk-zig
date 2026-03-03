const PathComponent = @import("path_component.zig").PathComponent;

/// Describes a finding for a Network Access Scope.
pub const AccessScopeAnalysisFinding = struct {
    /// The finding components.
    finding_components: ?[]const PathComponent = null,

    /// The ID of the finding.
    finding_id: ?[]const u8 = null,

    /// The ID of the Network Access Scope analysis.
    network_insights_access_scope_analysis_id: ?[]const u8 = null,

    /// The ID of the Network Access Scope.
    network_insights_access_scope_id: ?[]const u8 = null,
};
