const HarnessStatus = @import("harness_status.zig").HarnessStatus;

/// Summary information about a harness.
pub const HarnessSummary = struct {
    /// The ARN of the harness.
    arn: []const u8,

    /// The timestamp when the harness was created.
    created_at: i64,

    /// The ID of the harness.
    harness_id: []const u8,

    /// The name of the harness.
    harness_name: []const u8,

    /// The current status of the harness.
    status: HarnessStatus,

    /// The timestamp when the harness was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .harness_id = "harnessId",
        .harness_name = "harnessName",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
