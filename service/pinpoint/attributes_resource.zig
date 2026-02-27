/// Provides information about the type and the names of attributes that were
/// removed from all the endpoints that are associated with an application.
pub const AttributesResource = struct {
    /// The unique identifier for the application.
    application_id: []const u8,

    /// An array that specifies the names of the attributes that were removed from
    /// the endpoints.
    attributes: ?[]const []const u8,

    /// The type of attribute or attributes that were removed from the endpoints.
    /// Valid values are:
    ///
    /// * endpoint-custom-attributes - Custom attributes that describe endpoints.
    /// * endpoint-metric-attributes - Custom metrics that your app reports to
    ///   Amazon Pinpoint for endpoints.
    /// * endpoint-user-attributes - Custom attributes that describe users.
    attribute_type: []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .attributes = "Attributes",
        .attribute_type = "AttributeType",
    };
};
