const aws = @import("aws");

/// Information about a serialization/deserialization program (SerDe) that
/// serves as an
/// extractor and loader.
pub const SerDeInfo = struct {
    /// Name of the SerDe.
    name: ?[]const u8 = null,

    /// These key-value pairs define initialization parameters for the SerDe.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// Usually the class that implements the SerDe. An example is
    /// `org.apache.hadoop.hive.serde2.columnar.ColumnarSerDe`.
    serialization_library: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .parameters = "Parameters",
        .serialization_library = "SerializationLibrary",
    };
};
