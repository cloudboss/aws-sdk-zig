const aws = @import("aws");

const OperationStatus = @import("operation_status.zig").OperationStatus;

/// The operations performed by AWS Systems Manager for SAP.
pub const Operation = struct {
    /// The end time of the operation.
    end_time: ?i64 = null,

    /// The ID of the operation.
    id: ?[]const u8 = null,

    /// The time at which the operation was last updated.
    last_updated_time: ?i64 = null,

    /// The properties of the operation.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the operation.
    resource_arn: ?[]const u8 = null,

    /// The resource ID of the operation.
    resource_id: ?[]const u8 = null,

    /// The resource type of the operation.
    resource_type: ?[]const u8 = null,

    /// The start time of the operation.
    start_time: ?i64 = null,

    /// The status of the operation.
    status: ?OperationStatus = null,

    /// The status message of the operation.
    status_message: ?[]const u8 = null,

    /// The type of the operation.
    @"type": ?[]const u8 = null,

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
