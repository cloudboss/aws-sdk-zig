const aws = @import("aws");

/// A complex type that contains information about attributes associated with a
/// specific
/// service.
pub const ServiceAttributes = struct {
    /// A string map that contains the following information for the service that
    /// you specify in
    /// `ServiceArn`:
    ///
    /// * The attributes that apply to the service.
    ///
    /// * For each attribute, the applicable value.
    ///
    /// You can specify a total of 30 attributes.
    attributes: ?[]const aws.map.StringMapEntry,

    /// The ID of the Amazon Web Services account that created the namespace with
    /// which the service is associated.
    /// If this isn't your account ID, it is the ID of the account that shared the
    /// namespace with your
    /// account. For more information about shared namespaces, see [Cross-account
    /// Cloud Map
    /// namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the *Cloud Map Developer Guide*.
    resource_owner: ?[]const u8,

    /// The ARN of the service that the attributes are associated with.
    service_arn: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .resource_owner = "ResourceOwner",
        .service_arn = "ServiceArn",
    };
};
