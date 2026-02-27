/// Specifies the location of an occurrence of sensitive data in an Apache Avro
/// object container, Apache Parquet file, JSON file, or JSON Lines file.
pub const Record = struct {
    /// The path, as a JSONPath expression, to the sensitive data. For an Avro
    /// object container or Parquet file, this is the path to the field in the
    /// record (recordIndex) that contains the data. For a JSON or JSON Lines file,
    /// this is the path to the field or array that contains the data. If the data
    /// is a value in an array, the path also indicates which value contains the
    /// data.
    ///
    /// If Amazon Macie detects sensitive data in the name of any element in the
    /// path, Macie omits this field. If the name of an element exceeds 240
    /// characters, Macie truncates the name by removing characters from the
    /// beginning of the name. If the resulting full path exceeds 250 characters,
    /// Macie also truncates the path, starting with the first element in the path,
    /// until the path contains 250 or fewer characters.
    json_path: ?[]const u8,

    /// For an Avro object container or Parquet file, the record index, starting
    /// from 0, for the record that contains the sensitive data. For a JSON Lines
    /// file, the line index, starting from 0, for the line that contains the
    /// sensitive data. This value is always 0 for JSON files.
    record_index: ?i64,

    pub const json_field_names = .{
        .json_path = "jsonPath",
        .record_index = "recordIndex",
    };
};
