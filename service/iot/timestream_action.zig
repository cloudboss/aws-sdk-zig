const TimestreamDimension = @import("timestream_dimension.zig").TimestreamDimension;
const TimestreamTimestamp = @import("timestream_timestamp.zig").TimestreamTimestamp;

/// The Timestream rule action writes attributes (measures) from an MQTT message
/// into an Amazon Timestream table. For more information, see the
/// [Timestream](https://docs.aws.amazon.com/iot/latest/developerguide/timestream-rule-action.html)
/// topic rule action documentation.
pub const TimestreamAction = struct {
    /// The name of an Amazon Timestream database.
    database_name: []const u8,

    /// Metadata attributes of the time series that are written in each measure
    /// record.
    dimensions: []const TimestreamDimension,

    /// The ARN of the role that grants permission to write to the
    /// Amazon Timestream database table.
    role_arn: []const u8,

    /// The name of the database table into which to write the measure records.
    table_name: []const u8,

    /// Specifies an application-defined value to replace the default value assigned
    /// to the
    /// Timestream record's timestamp in the `time` column.
    ///
    /// You can use this property to specify the value and the precision of the
    /// Timestream
    /// record's timestamp. You can specify a value from the message payload or a
    /// value computed by
    /// a substitution template.
    ///
    /// If omitted, the topic rule action assigns the timestamp, in milliseconds, at
    /// the time it
    /// processed the rule.
    timestamp: ?TimestreamTimestamp = null,

    pub const json_field_names = .{
        .database_name = "databaseName",
        .dimensions = "dimensions",
        .role_arn = "roleArn",
        .table_name = "tableName",
        .timestamp = "timestamp",
    };
};
