const ResourceProperty = @import("resource_property.zig").ResourceProperty;

/// A resource in Amazon Web Services that Amazon Web Services Resource Explorer
/// has discovered, and for which it has stored information in the index of the
/// Amazon Web Services Region that contains the resource.
pub const Resource = struct {
    /// The [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource.
    arn: ?[]const u8,

    /// The date and time that Resource Explorer last queried this resource and
    /// updated the index with the latest information about the resource.
    last_reported_at: ?i64,

    /// The Amazon Web Services account that owns the resource.
    owning_account_id: ?[]const u8,

    /// A structure with additional type-specific details about the resource. These
    /// properties can be added by turning on integration between Resource Explorer
    /// and other Amazon Web Services services.
    properties: ?[]const ResourceProperty,

    /// The Amazon Web Services Region in which the resource was created and exists.
    region: ?[]const u8,

    /// The type of the resource.
    resource_type: ?[]const u8,

    /// The Amazon Web Services service that owns the resource and is responsible
    /// for creating and updating it.
    service: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .last_reported_at = "LastReportedAt",
        .owning_account_id = "OwningAccountId",
        .properties = "Properties",
        .region = "Region",
        .resource_type = "ResourceType",
        .service = "Service",
    };
};
