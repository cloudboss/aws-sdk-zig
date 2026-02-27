const ResourceAttribute = @import("resource_attribute.zig").ResourceAttribute;
const Task = @import("task.zig").Task;

/// Represents a migration task in a migration tool.
pub const MigrationTask = struct {
    /// Unique identifier that references the migration task. *Do not store personal
    /// data in this field.*
    migration_task_name: ?[]const u8,

    /// A name that identifies the vendor of the migration tool being used.
    progress_update_stream: ?[]const u8,

    /// Information about the resource that is being migrated. This data will be
    /// used to map the
    /// task to a resource in the Application Discovery Service repository.
    resource_attribute_list: ?[]const ResourceAttribute,

    /// Task object encapsulating task information.
    task: ?Task,

    /// The timestamp when the task was gathered.
    update_date_time: ?i64,

    pub const json_field_names = .{
        .migration_task_name = "MigrationTaskName",
        .progress_update_stream = "ProgressUpdateStream",
        .resource_attribute_list = "ResourceAttributeList",
        .task = "Task",
        .update_date_time = "UpdateDateTime",
    };
};
