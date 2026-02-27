const TargetStatus = @import("target_status.zig").TargetStatus;

/// Contains summary information about a gateway target. A target represents an
/// endpoint that the gateway can connect to.
pub const TargetSummary = struct {
    /// The timestamp when the target was created.
    created_at: i64,

    /// The description of the target.
    description: ?[]const u8,

    /// The name of the target.
    name: []const u8,

    /// The current status of the target.
    status: TargetStatus,

    /// The unique identifier of the target.
    target_id: []const u8,

    /// The timestamp when the target was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .status = "status",
        .target_id = "targetId",
        .updated_at = "updatedAt",
    };
};
