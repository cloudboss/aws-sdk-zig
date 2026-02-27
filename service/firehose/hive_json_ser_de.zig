/// The native Hive / HCatalog JsonSerDe. Used by Firehose for deserializing
/// data, which means converting it from the JSON format in preparation for
/// serializing it to
/// the Parquet or ORC format. This is one of two deserializers you can choose,
/// depending on
/// which one offers the functionality you need. The other option is the OpenX
/// SerDe.
pub const HiveJsonSerDe = struct {
    /// Indicates how you want Firehose to parse the date and timestamps that
    /// may be present in your input data JSON. To specify these format strings,
    /// follow the pattern
    /// syntax of JodaTime's DateTimeFormat format strings. For more information,
    /// see [Class
    /// DateTimeFormat](https://www.joda.org/joda-time/apidocs/org/joda/time/format/DateTimeFormat.html). You can also use the special value `millis` to
    /// parse timestamps in epoch milliseconds. If you don't specify a format,
    /// Firehose uses `java.sql.Timestamp::valueOf` by default.
    timestamp_formats: ?[]const []const u8,

    pub const json_field_names = .{
        .timestamp_formats = "TimestampFormats",
    };
};
