const HttpUrlDestinationConfiguration = @import("http_url_destination_configuration.zig").HttpUrlDestinationConfiguration;
const VpcDestinationConfiguration = @import("vpc_destination_configuration.zig").VpcDestinationConfiguration;

/// Configuration of the topic rule destination.
pub const TopicRuleDestinationConfiguration = struct {
    /// Configuration of the HTTP URL.
    http_url_configuration: ?HttpUrlDestinationConfiguration,

    /// Configuration of the virtual private cloud (VPC) connection.
    vpc_configuration: ?VpcDestinationConfiguration,

    pub const json_field_names = .{
        .http_url_configuration = "httpUrlConfiguration",
        .vpc_configuration = "vpcConfiguration",
    };
};
