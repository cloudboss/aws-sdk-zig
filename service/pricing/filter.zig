const FilterType = @import("filter_type.zig").FilterType;

/// The constraints that you want all returned products to match.
pub const Filter = struct {
    /// The product metadata field that you want to filter on. You can filter by
    /// just the service code to see all products for a specific service, filter by
    /// just the attribute name to see a specific attribute for multiple services,
    /// or use both a service code and an attribute name to retrieve only products
    /// that match both fields.
    ///
    /// Valid values include: `ServiceCode`, and all attribute names
    ///
    /// For example, you can filter by the `AmazonEC2` service code and the
    /// `volumeType` attribute name to get the prices for only Amazon EC2 volumes.
    field: []const u8,

    /// The type of filter that you want to use.
    ///
    /// Valid values are:
    ///
    /// * `TERM_MATCH`: Returns only products that match both the given filter field
    ///   and the given value.
    /// * `EQUALS`: Returns products that have a field value exactly matching the
    ///   provided value.
    /// * `CONTAINS`: Returns products where the field value contains the provided
    ///   value as a substring.
    /// * `ANY_OF`: Returns products where the field value is any of the provided
    ///   values.
    /// * `NONE_OF`: Returns products where the field value is not any of the
    ///   provided values.
    @"type": FilterType,

    /// The service code or attribute value that you want to filter by. If you're
    /// filtering by service code this is the actual service code, such as
    /// `AmazonEC2`. If you're filtering by attribute name, this is the attribute
    /// value that you want the returned products to match, such as a `Provisioned
    /// IOPS` volume.
    value: []const u8,

    pub const json_field_names = .{
        .field = "Field",
        .@"type" = "Type",
        .value = "Value",
    };
};
