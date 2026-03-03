const SchemaAttributeType = @import("schema_attribute_type.zig").SchemaAttributeType;

/// The provider schema attribute.
pub const ProviderSchemaAttribute = struct {
    /// The field name.
    field_name: []const u8,

    /// The hashing attribute of the provider schema.
    hashing: ?bool = null,

    /// The sub type of the provider schema attribute.
    sub_type: ?[]const u8 = null,

    /// The type of the provider schema attribute.
    ///
    /// LiveRamp supports: `NAME` | `NAME_FIRST` | `NAME_MIDDLE` | `NAME_LAST` |
    /// `ADDRESS` | `ADDRESS_STREET1` | `ADDRESS_STREET2` | `ADDRESS_STREET3` |
    /// `ADDRESS_CITY` | `ADDRESS_STATE` | `ADDRESS_COUNTRY` | `ADDRESS_POSTALCODE`
    /// | `PHONE` | `PHONE_NUMBER` | `EMAIL_ADDRESS` | `UNIQUE_ID` | `PROVIDER_ID`
    ///
    /// TransUnion supports: `NAME` | `NAME_FIRST` | `NAME_LAST` | `ADDRESS` |
    /// `ADDRESS_CITY` | `ADDRESS_STATE` | `ADDRESS_COUNTRY` | `ADDRESS_POSTALCODE`
    /// | `PHONE_NUMBER` | `EMAIL_ADDRESS` | `UNIQUE_ID` | `DATE` | `IPV4` | `IPV6`
    /// | `MAID`
    ///
    /// Unified ID 2.0 supports: `PHONE_NUMBER` | `EMAIL_ADDRESS` | `UNIQUE_ID`
    @"type": SchemaAttributeType,

    pub const json_field_names = .{
        .field_name = "fieldName",
        .hashing = "hashing",
        .sub_type = "subType",
        .@"type" = "type",
    };
};
