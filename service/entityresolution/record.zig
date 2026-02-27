const aws = @import("aws");

/// The record.
pub const Record = struct {
    /// The input source ARN of the record.
    input_source_arn: []const u8,

    /// The record's attribute map.
    record_attribute_map: []const aws.map.StringMapEntry,

    /// The unique ID of the record.
    unique_id: []const u8,

    pub const json_field_names = .{
        .input_source_arn = "inputSourceARN",
        .record_attribute_map = "recordAttributeMap",
        .unique_id = "uniqueId",
    };
};
