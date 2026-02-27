const XksProxyConnectivityType = @import("xks_proxy_connectivity_type.zig").XksProxyConnectivityType;

/// Detailed information about the external key store proxy (XKS proxy). Your
/// external key
/// store proxy translates KMS requests into a format that your external key
/// manager can
/// understand. These fields appear in a DescribeCustomKeyStores response only
/// when the `CustomKeyStoreType` is `EXTERNAL_KEY_STORE`.
pub const XksProxyConfigurationType = struct {
    /// The part of the external key store [proxy authentication
    /// credential](https://docs.aws.amazon.com/kms/latest/APIReference/API_CreateCustomKeyStore.html#KMS-CreateCustomKeyStore-request-XksProxyAuthenticationCredential) that uniquely identifies the secret access
    /// key.
    access_key_id: ?[]const u8,

    /// Indicates whether the external key store proxy uses a public endpoint or an
    /// Amazon VPC endpoint
    /// service to communicate with KMS.
    connectivity: ?XksProxyConnectivityType,

    /// The URI endpoint for the external key store proxy.
    ///
    /// If the external key store proxy has a public endpoint, it is displayed here.
    ///
    /// If the external key store proxy uses an Amazon VPC endpoint service name,
    /// this field displays
    /// the private DNS name associated with the VPC endpoint service.
    uri_endpoint: ?[]const u8,

    /// The path to the external key store proxy APIs.
    uri_path: ?[]const u8,

    /// The Amazon VPC endpoint service used to communicate with the external key
    /// store proxy. This
    /// field appears only when the external key store proxy uses an Amazon VPC
    /// endpoint service to
    /// communicate with KMS.
    vpc_endpoint_service_name: ?[]const u8,

    /// The Amazon Web Services account ID that owns the Amazon VPC endpoint service
    /// used to communicate with the
    /// external key store proxy (XKS). This field appears only when the XKS uses an
    /// VPC endpoint
    /// service to communicate with KMS.
    vpc_endpoint_service_owner: ?[]const u8,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .connectivity = "Connectivity",
        .uri_endpoint = "UriEndpoint",
        .uri_path = "UriPath",
        .vpc_endpoint_service_name = "VpcEndpointServiceName",
        .vpc_endpoint_service_owner = "VpcEndpointServiceOwner",
    };
};
