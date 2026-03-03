const AwsCloudMapInstanceAttribute = @import("aws_cloud_map_instance_attribute.zig").AwsCloudMapInstanceAttribute;
const IpPreference = @import("ip_preference.zig").IpPreference;

/// An object that represents the Cloud Map service discovery information for
/// your virtual node.
///
/// Cloud Map is not available in the eu-south-1 Region.
pub const AwsCloudMapServiceDiscovery = struct {
    /// A string map that contains attributes with values that you can use to filter
    /// instances
    /// by any custom attribute that you specified when you registered the instance.
    /// Only instances
    /// that match all of the specified key/value pairs will be returned.
    attributes: ?[]const AwsCloudMapInstanceAttribute = null,

    /// The preferred IP version that this virtual node uses. Setting the IP
    /// preference on the
    /// virtual node only overrides the IP preference set for the mesh on this
    /// specific
    /// node.
    ip_preference: ?IpPreference = null,

    /// The name of the Cloud Map namespace to use.
    namespace_name: []const u8,

    /// The name of the Cloud Map service to use.
    service_name: []const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .ip_preference = "ipPreference",
        .namespace_name = "namespaceName",
        .service_name = "serviceName",
    };
};
