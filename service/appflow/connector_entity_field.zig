const aws = @import("aws");

const DestinationFieldProperties = @import("destination_field_properties.zig").DestinationFieldProperties;
const SourceFieldProperties = @import("source_field_properties.zig").SourceFieldProperties;
const SupportedFieldTypeDetails = @import("supported_field_type_details.zig").SupportedFieldTypeDetails;

/// Describes the data model of a connector field. For example, for an
/// *account* entity, the fields would be *account name*,
/// *account ID*, and so on.
pub const ConnectorEntityField = struct {
    /// A map that has specific properties related to the ConnectorEntityField.
    custom_properties: ?[]const aws.map.StringMapEntry,

    /// Default value that can be assigned to this field.
    default_value: ?[]const u8,

    /// A description of the connector entity field.
    description: ?[]const u8,

    /// The properties applied to a field when the connector is being used as a
    /// destination.
    destination_properties: ?DestinationFieldProperties,

    /// The unique identifier of the connector field.
    identifier: []const u8,

    /// Booelan value that indicates whether this field is deprecated or not.
    is_deprecated: bool = false,

    /// Booelan value that indicates whether this field can be used as a primary
    /// key.
    is_primary_key: bool = false,

    /// The label applied to a connector entity field.
    label: ?[]const u8,

    /// The parent identifier of the connector field.
    parent_identifier: ?[]const u8,

    /// The properties that can be applied to a field when the connector is being
    /// used as a
    /// source.
    source_properties: ?SourceFieldProperties,

    /// Contains details regarding the supported `FieldType`, including the
    /// corresponding `filterOperators` and `supportedValues`.
    supported_field_type_details: ?SupportedFieldTypeDetails,

    pub const json_field_names = .{
        .custom_properties = "customProperties",
        .default_value = "defaultValue",
        .description = "description",
        .destination_properties = "destinationProperties",
        .identifier = "identifier",
        .is_deprecated = "isDeprecated",
        .is_primary_key = "isPrimaryKey",
        .label = "label",
        .parent_identifier = "parentIdentifier",
        .source_properties = "sourceProperties",
        .supported_field_type_details = "supportedFieldTypeDetails",
    };
};
