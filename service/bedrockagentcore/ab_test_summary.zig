const ABTestExecutionStatus = @import("ab_test_execution_status.zig").ABTestExecutionStatus;
const ABTestStatus = @import("ab_test_status.zig").ABTestStatus;

/// Summary information about an A/B test.
pub const ABTestSummary = struct {
    /// The Amazon Resource Name (ARN) of the A/B test.
    ab_test_arn: []const u8,

    /// The unique identifier of the A/B test.
    ab_test_id: []const u8,

    /// The timestamp when the A/B test was created.
    created_at: i64,

    /// The description of the A/B test.
    description: ?[]const u8 = null,

    /// The execution status of the A/B test.
    execution_status: ABTestExecutionStatus,

    /// The Amazon Resource Name (ARN) of the gateway used for traffic splitting.
    gateway_arn: ?[]const u8 = null,

    /// The name of the A/B test.
    name: []const u8,

    /// The current status of the A/B test.
    status: ABTestStatus,

    /// The timestamp when the A/B test was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .ab_test_arn = "abTestArn",
        .ab_test_id = "abTestId",
        .created_at = "createdAt",
        .description = "description",
        .execution_status = "executionStatus",
        .gateway_arn = "gatewayArn",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
