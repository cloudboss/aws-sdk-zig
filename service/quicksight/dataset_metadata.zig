const TopicCalculatedField = @import("topic_calculated_field.zig").TopicCalculatedField;
const TopicColumn = @import("topic_column.zig").TopicColumn;
const DataAggregation = @import("data_aggregation.zig").DataAggregation;
const TopicFilter = @import("topic_filter.zig").TopicFilter;
const TopicNamedEntity = @import("topic_named_entity.zig").TopicNamedEntity;

/// A structure that represents a dataset.
pub const DatasetMetadata = struct {
    /// The list of calculated field definitions.
    calculated_fields: ?[]const TopicCalculatedField,

    /// The list of column definitions.
    columns: ?[]const TopicColumn,

    /// The definition of a data aggregation.
    data_aggregation: ?DataAggregation,

    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: []const u8,

    /// The description of the dataset.
    dataset_description: ?[]const u8,

    /// The name of the dataset.
    dataset_name: ?[]const u8,

    /// The list of filter definitions.
    filters: ?[]const TopicFilter,

    /// The list of named entities definitions.
    named_entities: ?[]const TopicNamedEntity,

    pub const json_field_names = .{
        .calculated_fields = "CalculatedFields",
        .columns = "Columns",
        .data_aggregation = "DataAggregation",
        .dataset_arn = "DatasetArn",
        .dataset_description = "DatasetDescription",
        .dataset_name = "DatasetName",
        .filters = "Filters",
        .named_entities = "NamedEntities",
    };
};
