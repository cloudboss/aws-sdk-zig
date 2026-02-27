const aws = @import("aws");

const ConnectorOperator = @import("connector_operator.zig").ConnectorOperator;
const TaskType = @import("task_type.zig").TaskType;

/// A class for modeling different type of tasks. Task implementation varies
/// based on the
/// `TaskType`.
pub const Task = struct {
    /// The operation to be performed on the provided source fields.
    connector_operator: ?ConnectorOperator,

    /// A field in a destination connector, or a field value against which Amazon
    /// AppFlow
    /// validates a source field.
    destination_field: ?[]const u8,

    /// The source fields to which a particular task is applied.
    source_fields: []const []const u8,

    /// A map used to store task-related information. The execution service looks
    /// for particular
    /// information based on the `TaskType`.
    task_properties: ?[]const aws.map.StringMapEntry,

    /// Specifies the particular task implementation that Amazon AppFlow performs.
    task_type: TaskType,

    pub const json_field_names = .{
        .connector_operator = "connectorOperator",
        .destination_field = "destinationField",
        .source_fields = "sourceFields",
        .task_properties = "taskProperties",
        .task_type = "taskType",
    };
};
