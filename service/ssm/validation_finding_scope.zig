const ValidationFindingScopeType = @import("validation_finding_scope_type.zig").ValidationFindingScopeType;

/// Identifies the specific resource scope of a validation finding.
pub const ValidationFindingScope = struct {
    /// The ID of the resource within the scope.
    id: ?[]const u8 = null,

    /// The type of the resource scope.
    @"type": ?ValidationFindingScopeType = null,

    pub const json_field_names = .{
        .id = "Id",
        .@"type" = "Type",
    };
};
