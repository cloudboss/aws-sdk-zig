const InfluxDBVersion = @import("influx_db_version.zig").InfluxDBVersion;
const InfluxDBSecretType = @import("influx_db_secret_type.zig").InfluxDBSecretType;

/// The properties of an existing InfluxDB topic rule destination, as returned
/// by
/// `CreateTopicRuleDestination` and
/// `GetTopicRuleDestination`.
pub const InfluxDBDestinationProperties = struct {
    /// The URL of the InfluxDB instance that the destination writes to.
    endpoint: ?[]const u8 = null,

    /// The major version of the InfluxDB instance. Valid values are `V2` and
    /// `V3`.
    influx_db_version: ?InfluxDBVersion = null,

    /// The ARN or name of the Amazon Web Services Secrets Manager secret that
    /// contains the InfluxDB API
    /// token.
    secret_id: ?[]const u8 = null,

    /// The key that is read from the secret value when the secret contains a JSON
    /// object.
    secret_key: ?[]const u8 = null,

    /// The type of the secret that contains the InfluxDB API token. Valid values
    /// are
    /// `SecretString` and `SecretBinary`.
    secret_type: ?InfluxDBSecretType = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
        .influx_db_version = "influxDBVersion",
        .secret_id = "secretId",
        .secret_key = "secretKey",
        .secret_type = "secretType",
    };
};
