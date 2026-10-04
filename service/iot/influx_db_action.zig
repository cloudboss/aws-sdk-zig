const aws = @import("aws");

const InfluxDBBatchConfig = @import("influx_db_batch_config.zig").InfluxDBBatchConfig;
const InfluxDBTimestampUnit = @import("influx_db_timestamp_unit.zig").InfluxDBTimestampUnit;

/// The InfluxDB rule action converts the message payload into InfluxDB line
/// protocol. It
/// writes the result to a table in an InfluxDB database. The database can be an
/// Amazon
/// Timestream for InfluxDB instance or a self-managed InfluxDB cluster.
///
/// The action connects to InfluxDB through an InfluxDB topic rule destination,
/// which must
/// be in the `ENABLED` state before the action can write data.
pub const InfluxDBAction = struct {
    /// The batching configuration for the action. When present, IoT collects data
    /// points
    /// from multiple messages and writes them to InfluxDB in a single request.
    ///
    /// If omitted, each message is written to InfluxDB in its own request.
    batch_config: ?InfluxDBBatchConfig = null,

    /// The name of the InfluxDB database to write to. In InfluxDB 2, this is the
    /// name of the
    /// bucket.
    database_name: []const u8,

    /// The ARN of the InfluxDB topic rule destination that identifies the InfluxDB
    /// instance to
    /// write to.
    destination_arn: []const u8,

    /// The name of the InfluxDB organization that owns the database.
    ///
    /// A write to an InfluxDB 2 instance fails if this value isn't set. This value
    /// isn't used
    /// when the destination is an InfluxDB 3 instance.
    organization: ?[]const u8 = null,

    /// The ARN of the role that grants permission to retrieve the InfluxDB API
    /// token from
    /// Amazon Web Services Secrets Manager.
    role_arn: []const u8,

    /// The name of the table to write the data point to. This is the measurement
    /// name of the
    /// InfluxDB line protocol record.
    ///
    /// Accepts substitution templates.
    table_name: []const u8,

    /// The set of tags to write with each data point. Tags are the indexed metadata
    /// of an
    /// InfluxDB data point.
    ///
    /// Tag names and tag values accept substitution templates. A tag name can't use
    /// the
    /// `@{...}` per-element form. A tag name must resolve to the same value for
    /// every
    /// element of an array payload.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The precision of the timestamp written with each data point. Valid values
    /// are
    /// `s` (seconds), `ms` (milliseconds), `us` (microseconds),
    /// and `ns` (nanoseconds).
    ///
    /// If omitted, the topic rule action uses `ms`.
    timestamp_unit: ?InfluxDBTimestampUnit = null,

    pub const json_field_names = .{
        .batch_config = "batchConfig",
        .database_name = "databaseName",
        .destination_arn = "destinationArn",
        .organization = "organization",
        .role_arn = "roleArn",
        .table_name = "tableName",
        .tags = "tags",
        .timestamp_unit = "timestampUnit",
    };
};
