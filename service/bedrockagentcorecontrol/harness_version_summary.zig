const HarnessStatus = @import("harness_status.zig").HarnessStatus;

/// Summary information about a single version of a harness.
pub const HarnessVersionSummary = struct {
    /// The ARN of the harness.
    arn: []const u8,

    /// The timestamp when this harness version was created.
    created_at: i64,

    /// Reason why the create or update operation for this harness version failed.
    failure_reason: ?[]const u8 = null,

    /// The ID of the harness.
    harness_id: []const u8,

    /// The name of the harness.
    harness_name: []const u8,

    /// The version of the harness that this summary describes.
    harness_version: []const u8,

    /// The status of this harness version.
    status: HarnessStatus,

    /// The timestamp when this harness version was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .failure_reason = "failureReason",
        .harness_id = "harnessId",
        .harness_name = "harnessName",
        .harness_version = "harnessVersion",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
