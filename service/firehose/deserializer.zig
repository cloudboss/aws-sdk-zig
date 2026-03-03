const HiveJsonSerDe = @import("hive_json_ser_de.zig").HiveJsonSerDe;
const OpenXJsonSerDe = @import("open_x_json_ser_de.zig").OpenXJsonSerDe;

/// The deserializer you want Firehose to use for converting the input data
/// from JSON. Firehose then serializes the data to its final format using the
/// Serializer. Firehose supports two types of deserializers:
/// the [Apache Hive JSON
/// SerDe](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-JSON) and the [OpenX JSON SerDe](https://github.com/rcongiu/Hive-JSON-Serde).
pub const Deserializer = struct {
    /// The native Hive / HCatalog JsonSerDe. Used by Firehose for deserializing
    /// data, which means converting it from the JSON format in preparation for
    /// serializing it to
    /// the Parquet or ORC format. This is one of two deserializers you can choose,
    /// depending on
    /// which one offers the functionality you need. The other option is the OpenX
    /// SerDe.
    hive_json_ser_de: ?HiveJsonSerDe = null,

    /// The OpenX SerDe. Used by Firehose for deserializing data, which means
    /// converting it from the JSON format in preparation for serializing it to the
    /// Parquet or ORC
    /// format. This is one of two deserializers you can choose, depending on which
    /// one offers the
    /// functionality you need. The other option is the native Hive / HCatalog
    /// JsonSerDe.
    open_x_json_ser_de: ?OpenXJsonSerDe = null,

    pub const json_field_names = .{
        .hive_json_ser_de = "HiveJsonSerDe",
        .open_x_json_ser_de = "OpenXJsonSerDe",
    };
};
