const AssociationMode = @import("association_mode.zig").AssociationMode;

/// Contains summary information about a custom detection rule association.
pub const AssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: []const u8,

    /// The unique identifier for the association.
    association_id: []const u8,

    /// The timestamp when the association was created.
    created_at: i64,

    /// The timestamp when the association expires.
    expires_at: ?i64 = null,

    /// The rule execution mode. Valid values: `LIVE` | `DRY_RUN`.
    mode: AssociationMode,

    /// The unique identifier for the custom detection rule.
    rule_id: []const u8,

    /// The timestamp when the association was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .association_id = "AssociationId",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .mode = "Mode",
        .rule_id = "RuleId",
        .updated_at = "UpdatedAt",
    };
};
