const ValueConverter = @import("value_converter.zig").ValueConverter;

/// Configuration that controls how Apache Kafka record values are deserialized
/// for the destination.
pub const RecordConverter = struct {
    /// The deserialization format applied to Apache Kafka record values.
    value_converter: ValueConverter,

    pub const json_field_names = .{
        .value_converter = "ValueConverter",
    };
};
