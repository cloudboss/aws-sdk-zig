const aws = @import("aws");

const ErrorDetails = @import("error_details.zig").ErrorDetails;
const ExportImageTaskState = @import("export_image_task_state.zig").ExportImageTaskState;

/// Information about an export image task, including its current state,
/// timestamps, and any error details.
pub const ExportImageTask = struct {
    /// The description that will be applied to the exported EC2 AMI.
    ami_description: ?[]const u8,

    /// The ID of the EC2 AMI that was created by this export task. This field is
    /// only populated when the task completes successfully.
    ami_id: ?[]const u8,

    /// The name of the EC2 AMI that will be created by this export task.
    ami_name: []const u8,

    /// The date and time when the export image task was created.
    created_date: i64,

    /// Details about any errors that occurred during the export process. This field
    /// is only populated when the task fails.
    error_details: ?[]const ErrorDetails,

    /// The ARN of the WorkSpaces Applications image being exported.
    image_arn: []const u8,

    /// The current state of the export image task, such as PENDING, RUNNING,
    /// COMPLETED, or FAILED.
    state: ?ExportImageTaskState,

    /// The tags that will be applied to the exported EC2 AMI.
    tag_specifications: ?[]const aws.map.StringMapEntry,

    /// The unique identifier for the export image task. Use this ID to track the
    /// task's progress and retrieve its details.
    task_id: []const u8,

    pub const json_field_names = .{
        .ami_description = "AmiDescription",
        .ami_id = "AmiId",
        .ami_name = "AmiName",
        .created_date = "CreatedDate",
        .error_details = "ErrorDetails",
        .image_arn = "ImageArn",
        .state = "State",
        .tag_specifications = "TagSpecifications",
        .task_id = "TaskId",
    };
};
