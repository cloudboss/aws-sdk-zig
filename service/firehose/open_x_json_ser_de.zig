const aws = @import("aws");

/// The OpenX SerDe. Used by Firehose for deserializing data, which means
/// converting it from the JSON format in preparation for serializing it to the
/// Parquet or ORC
/// format. This is one of two deserializers you can choose, depending on which
/// one offers the
/// functionality you need. The other option is the native Hive / HCatalog
/// JsonSerDe.
pub const OpenXJsonSerDe = struct {
    /// When set to `true`, which is the default, Firehose converts
    /// JSON keys to lowercase before deserializing them.
    case_insensitive: ?bool,

    /// Maps column names to JSON keys that aren't identical to the column names.
    /// This is
    /// useful when the JSON contains keys that are Hive keywords. For example,
    /// `timestamp` is a Hive keyword. If you have a JSON key named
    /// `timestamp`, set this parameter to `{"ts": "timestamp"}` to map
    /// this key to a column named `ts`.
    column_to_json_key_mappings: ?[]const aws.map.StringMapEntry,

    /// When set to `true`, specifies that the names of the keys include dots and
    /// that you want Firehose to replace them with underscores. This is useful
    /// because Apache Hive does not allow dots in column names. For example, if the
    /// JSON contains
    /// a key whose name is "a.b", you can define the column name to be "a_b" when
    /// using this
    /// option.
    ///
    /// The default is `false`.
    convert_dots_in_json_keys_to_underscores: ?bool,

    pub const json_field_names = .{
        .case_insensitive = "CaseInsensitive",
        .column_to_json_key_mappings = "ColumnToJsonKeyMappings",
        .convert_dots_in_json_keys_to_underscores = "ConvertDotsInJsonKeysToUnderscores",
    };
};
