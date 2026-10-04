const HttpUrlDestinationConfiguration = @import("http_url_destination_configuration.zig").HttpUrlDestinationConfiguration;
const InfluxDBDestinationConfiguration = @import("influx_db_destination_configuration.zig").InfluxDBDestinationConfiguration;
const VpcDestinationConfiguration = @import("vpc_destination_configuration.zig").VpcDestinationConfiguration;

/// Configuration of the topic rule destination.
pub const TopicRuleDestinationConfiguration = struct {
    /// Configuration of the HTTP URL.
    http_url_configuration: ?HttpUrlDestinationConfiguration = null,

    /// The configuration of an InfluxDB topic rule destination, which you specify
    /// when you
    /// call `CreateTopicRuleDestination`.
    influx_db_configuration: ?InfluxDBDestinationConfiguration = null,

    /// Configuration of the virtual private cloud (VPC) connection.
    vpc_configuration: ?VpcDestinationConfiguration = null,

    pub const json_field_names = .{
        .http_url_configuration = "httpUrlConfiguration",
        .influx_db_configuration = "influxDBConfiguration",
        .vpc_configuration = "vpcConfiguration",
    };
};
