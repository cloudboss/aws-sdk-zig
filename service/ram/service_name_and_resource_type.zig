const ResourceRegionScope = @import("resource_region_scope.zig").ResourceRegionScope;

/// Information about a shareable resource type and the Amazon Web Services
/// service to which resources
/// of that type belong.
pub const ServiceNameAndResourceType = struct {
    /// Specifies the scope of visibility of resources of this type:
    ///
    /// * **REGIONAL** – The resource can be
    /// accessed only by using requests that target the Amazon Web Services Region
    /// in which the
    /// resource exists.
    ///
    /// * **GLOBAL** – The resource can be accessed
    /// from any Amazon Web Services Region.
    resource_region_scope: ?ResourceRegionScope,

    /// The type of the resource. This takes the form of:
    /// `service-code`:`resource-code`, and is case-insensitive. For
    /// example, an Amazon EC2 Subnet would be represented by the string
    /// `ec2:subnet`.
    resource_type: ?[]const u8,

    /// The name of the Amazon Web Services service to which resources of this type
    /// belong.
    service_name: ?[]const u8,

    pub const json_field_names = .{
        .resource_region_scope = "resourceRegionScope",
        .resource_type = "resourceType",
        .service_name = "serviceName",
    };
};
