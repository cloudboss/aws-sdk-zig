const aws = @import("aws");

/// The properties of the thing, including thing name, thing type name, and a
/// list of thing
/// attributes.
pub const ThingAttribute = struct {
    /// A list of thing attributes which are name-value pairs.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The thing ARN.
    thing_arn: ?[]const u8 = null,

    /// The name of the thing.
    thing_name: ?[]const u8 = null,

    /// The name of the thing type, if the thing has been associated with a type.
    thing_type_name: ?[]const u8 = null,

    /// The version of the thing record in the registry.
    version: i64 = 0,

    pub const json_field_names = .{
        .attributes = "attributes",
        .thing_arn = "thingArn",
        .thing_name = "thingName",
        .thing_type_name = "thingTypeName",
        .version = "version",
    };
};
