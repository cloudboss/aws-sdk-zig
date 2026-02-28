const aws = @import("aws");

const OperationStatus = @import("operation_status.zig").OperationStatus;

/// The operations performed by AWS Systems Manager for SAP.
pub const Operation = struct {
    /// The end time of the operation.
    end_time: ?i64,

    /// The ID of the operation.
    id: ?[]const u8,

    /// The time at which the operation was last updated.
    last_updated_time: ?i64,

    /// The properties of the operation.
    properties: ?[]const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of the operation.
    resource_arn: ?[]const u8,

    /// The resource ID of the operation.
    resource_id: ?[]const u8,

    /// The resource type of the operation.
    resource_type: ?[]const u8,

    /// The start time of the operation.
    start_time: ?i64,

    /// The status of the operation.
    status: ?OperationStatus,

    /// The status message of the operation.
    status_message: ?[]const u8,

    /// The type of the operation.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .id = "Id",
        .last_updated_time = "LastUpdatedTime",
        .properties = "Properties",
        .resource_arn = "ResourceArn",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
        .@"type" = "Type",
    };
};
