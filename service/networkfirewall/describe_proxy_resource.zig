const ListenerProperty = @import("listener_property.zig").ListenerProperty;
const ProxyModifyState = @import("proxy_modify_state.zig").ProxyModifyState;
const ProxyState = @import("proxy_state.zig").ProxyState;
const Tag = @import("tag.zig").Tag;
const TlsInterceptProperties = @import("tls_intercept_properties.zig").TlsInterceptProperties;

/// Proxy attached to a NAT gateway.
pub const DescribeProxyResource = struct {
    /// Time the Proxy was created.
    create_time: ?i64 = null,

    /// Time the Proxy was deleted.
    delete_time: ?i64 = null,

    /// Failure code for cases when the Proxy fails to attach or update.
    failure_code: ?[]const u8 = null,

    /// Failure message for cases when the Proxy fails to attach or update.
    failure_message: ?[]const u8 = null,

    /// Listener properties for HTTP and HTTPS traffic.
    listener_properties: ?[]const ListenerProperty = null,

    /// The NAT Gateway for the proxy.
    nat_gateway_id: ?[]const u8 = null,

    /// The private DNS name of the Proxy.
    private_dns_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a proxy.
    proxy_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a proxy configuration.
    proxy_configuration_arn: ?[]const u8 = null,

    /// The descriptive name of the proxy configuration. You can't change the name
    /// of a proxy configuration after you create it.
    proxy_configuration_name: ?[]const u8 = null,

    /// Current modification status of the Proxy.
    proxy_modify_state: ?ProxyModifyState = null,

    /// The descriptive name of the proxy. You can't change the name of a proxy
    /// after you create it.
    proxy_name: ?[]const u8 = null,

    /// Current attachment/detachment status of the Proxy.
    proxy_state: ?ProxyState = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// TLS decryption on traffic to filter on attributes in the HTTP header.
    tls_intercept_properties: ?TlsInterceptProperties = null,

    /// Time the Proxy was updated.
    update_time: ?i64 = null,

    /// The service endpoint created in the VPC.
    vpc_endpoint_service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .delete_time = "DeleteTime",
        .failure_code = "FailureCode",
        .failure_message = "FailureMessage",
        .listener_properties = "ListenerProperties",
        .nat_gateway_id = "NatGatewayId",
        .private_dns_name = "PrivateDNSName",
        .proxy_arn = "ProxyArn",
        .proxy_configuration_arn = "ProxyConfigurationArn",
        .proxy_configuration_name = "ProxyConfigurationName",
        .proxy_modify_state = "ProxyModifyState",
        .proxy_name = "ProxyName",
        .proxy_state = "ProxyState",
        .tags = "Tags",
        .tls_intercept_properties = "TlsInterceptProperties",
        .update_time = "UpdateTime",
        .vpc_endpoint_service_name = "VpcEndpointServiceName",
    };
};
