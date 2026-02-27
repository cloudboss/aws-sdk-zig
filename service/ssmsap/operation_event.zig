const Resource = @import("resource.zig").Resource;
const OperationEventStatus = @import("operation_event_status.zig").OperationEventStatus;

/// An operation event returns details for an operation, including key
/// milestones which can be used to monitor and track operations in progress.
///
/// Operation events contain:
///
/// * Description string
/// * Resource, including its ARN and type
/// * Status
/// * StatusMessage string
/// * TimeStamp
///
/// Operation event examples include StartApplication or StopApplication.
pub const OperationEvent = struct {
    /// A description of the operation event. For example, "Stop the EC2 instance
    /// i-abcdefgh987654321".
    description: ?[]const u8,

    /// The resource involved in the operations event.
    ///
    /// Contains `ResourceArn` ARN and `ResourceType`.
    resource: ?Resource,

    /// The status of the operation event. The possible statuses are: `IN_PROGRESS`,
    /// `COMPLETED`, and `FAILED`.
    status: ?OperationEventStatus,

    /// The status message relating to a specific operation event.
    status_message: ?[]const u8,

    /// The timestamp of the specified operation event.
    timestamp: ?i64,

    pub const json_field_names = .{
        .description = "Description",
        .resource = "Resource",
        .status = "Status",
        .status_message = "StatusMessage",
        .timestamp = "Timestamp",
    };
};
