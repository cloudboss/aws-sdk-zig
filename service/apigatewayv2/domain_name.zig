const aws = @import("aws");

const DomainNameConfiguration = @import("domain_name_configuration.zig").DomainNameConfiguration;
const MutualTlsAuthentication = @import("mutual_tls_authentication.zig").MutualTlsAuthentication;
const RoutingMode = @import("routing_mode.zig").RoutingMode;

/// Represents a domain name.
pub const DomainName = struct {
    /// The API mapping selection expression.
    api_mapping_selection_expression: ?[]const u8 = null,

    /// The name of the DomainName resource.
    domain_name: []const u8,

    domain_name_arn: ?[]const u8 = null,

    /// The domain name configurations.
    domain_name_configurations: ?[]const DomainNameConfiguration = null,

    /// The mutual TLS authentication configuration for a custom domain name.
    mutual_tls_authentication: ?MutualTlsAuthentication = null,

    /// The routing mode.
    routing_mode: ?RoutingMode = null,

    /// The collection of tags associated with a domain name.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .api_mapping_selection_expression = "ApiMappingSelectionExpression",
        .domain_name = "DomainName",
        .domain_name_arn = "DomainNameArn",
        .domain_name_configurations = "DomainNameConfigurations",
        .mutual_tls_authentication = "MutualTlsAuthentication",
        .routing_mode = "RoutingMode",
        .tags = "Tags",
    };
};
