const ThingTypeMetadata = @import("thing_type_metadata.zig").ThingTypeMetadata;
const ThingTypeProperties = @import("thing_type_properties.zig").ThingTypeProperties;

/// The definition of the thing type, including thing type name and description.
pub const ThingTypeDefinition = struct {
    /// The thing type ARN.
    thing_type_arn: ?[]const u8 = null,

    /// The ThingTypeMetadata contains additional information about the thing type
    /// including: creation date and
    /// time, a value indicating whether the thing type is deprecated, and a date
    /// and time when it was
    /// deprecated.
    thing_type_metadata: ?ThingTypeMetadata = null,

    /// The name of the thing type.
    thing_type_name: ?[]const u8 = null,

    /// The ThingTypeProperties for the thing type.
    thing_type_properties: ?ThingTypeProperties = null,

    pub const json_field_names = .{
        .thing_type_arn = "thingTypeArn",
        .thing_type_metadata = "thingTypeMetadata",
        .thing_type_name = "thingTypeName",
        .thing_type_properties = "thingTypeProperties",
    };
};
