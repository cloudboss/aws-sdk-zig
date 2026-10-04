const InfluxDBVersion = @import("influx_db_version.zig").InfluxDBVersion;
const InfluxDBSecretType = @import("influx_db_secret_type.zig").InfluxDBSecretType;

/// The configuration of an InfluxDB topic rule destination.
pub const InfluxDBDestinationConfiguration = struct {
    /// The URL of the InfluxDB instance to write to.
    endpoint: []const u8,

    /// The major version of the InfluxDB instance. Valid values are `V2` and
    /// `V3`.
    influx_db_version: InfluxDBVersion,

    /// The ARN or name of the Amazon Web Services Secrets Manager secret that
    /// contains the InfluxDB API
    /// token.
    secret_id: []const u8,

    /// The key to read from the secret value when the secret contains a JSON
    /// object. If
    /// omitted, IoT uses the entire secret value as the InfluxDB API token.
    secret_key: ?[]const u8 = null,

    /// The type of the secret that contains the InfluxDB API token. Valid values
    /// are
    /// `SecretString` and `SecretBinary`.
    ///
    /// If omitted, IoT reads the secret as a string.
    secret_type: ?InfluxDBSecretType = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
        .influx_db_version = "influxDBVersion",
        .secret_id = "secretId",
        .secret_key = "secretKey",
        .secret_type = "secretType",
    };
};
