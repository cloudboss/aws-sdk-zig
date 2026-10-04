const RecordConverter = @import("record_converter.zig").RecordConverter;
const RecordSchema = @import("record_schema.zig").RecordSchema;

/// Configuration of an Apache Kafka topic that feeds a channel.
pub const TopicConfiguration = struct {
    /// Configuration that controls how Apache Kafka record values are deserialized
    /// for the destination.
    record_converter: RecordConverter,

    /// The schema used to validate records when the value converter requires one
    /// (for example, JSON_SCHEMA_GSR).
    record_schema: ?RecordSchema = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the topic.
    topic_arn: []const u8,

    pub const json_field_names = .{
        .record_converter = "RecordConverter",
        .record_schema = "RecordSchema",
        .topic_arn = "TopicArn",
    };
};
