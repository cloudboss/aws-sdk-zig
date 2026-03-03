const TaskTemplateStatus = @import("task_template_status.zig").TaskTemplateStatus;

/// Contains summary information about the task template.
pub const TaskTemplateMetadata = struct {
    /// The Amazon Resource Name (ARN) of the task template.
    arn: ?[]const u8 = null,

    /// The timestamp when the task template was created.
    created_time: ?i64 = null,

    /// The description of the task template.
    description: ?[]const u8 = null,

    /// A unique identifier for the task template.
    id: ?[]const u8 = null,

    /// The timestamp when the task template was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the task template.
    name: ?[]const u8 = null,

    /// Marks a template as `ACTIVE` or `INACTIVE` for a task to refer to it.
    /// Tasks can only be created from `ACTIVE` templates.
    /// If a template is marked as `INACTIVE`, then a task that refers to this
    /// template cannot be created.
    status: ?TaskTemplateStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .id = "Id",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
    };
};
