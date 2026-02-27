/// An occurrence of sensitive data in an Apache Avro object container or an
/// Apache Parquet file.
pub const Record = struct {
    /// The path, as a JSONPath expression, to the field in the record that contains
    /// the data. If the field name is longer than 20 characters, it is truncated.
    /// If the path is longer than 250 characters, it is truncated.
    json_path: ?[]const u8,

    /// The record index, starting from 0, for the record that contains the data.
    record_index: ?i64,

    pub const json_field_names = .{
        .json_path = "JsonPath",
        .record_index = "RecordIndex",
    };
};
