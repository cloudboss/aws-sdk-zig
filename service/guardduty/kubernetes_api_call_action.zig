const RemoteIpDetails = @import("remote_ip_details.zig").RemoteIpDetails;

/// Information about the Kubernetes API call action described in this finding.
pub const KubernetesApiCallAction = struct {
    /// The name of the namespace where the Kubernetes API call action takes place.
    namespace: ?[]const u8 = null,

    /// Parameters related to the Kubernetes API call action.
    parameters: ?[]const u8 = null,

    remote_ip_details: ?RemoteIpDetails = null,

    /// The Kubernetes API request URI.
    request_uri: ?[]const u8 = null,

    /// The resource component in the Kubernetes API call action.
    resource: ?[]const u8 = null,

    /// The name of the resource in the Kubernetes API call action.
    resource_name: ?[]const u8 = null,

    /// The IP of the Kubernetes API caller and the IPs of any proxies or load
    /// balancers between the caller and the API endpoint.
    source_ips: ?[]const []const u8 = null,

    /// The resulting HTTP response code of the Kubernetes API call action.
    status_code: ?i32 = null,

    /// The name of the sub-resource in the Kubernetes API call action.
    subresource: ?[]const u8 = null,

    /// The user agent of the caller of the Kubernetes API.
    user_agent: ?[]const u8 = null,

    /// The Kubernetes API request HTTP verb.
    verb: ?[]const u8 = null,

    pub const json_field_names = .{
        .namespace = "Namespace",
        .parameters = "Parameters",
        .remote_ip_details = "RemoteIpDetails",
        .request_uri = "RequestUri",
        .resource = "Resource",
        .resource_name = "ResourceName",
        .source_ips = "SourceIps",
        .status_code = "StatusCode",
        .subresource = "Subresource",
        .user_agent = "UserAgent",
        .verb = "Verb",
    };
};
