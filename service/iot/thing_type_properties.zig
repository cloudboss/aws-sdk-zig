const Mqtt5Configuration = @import("mqtt_5_configuration.zig").Mqtt5Configuration;

/// The ThingTypeProperties contains information about the thing type including:
/// a thing type description,
/// and a list of searchable thing attribute names.
pub const ThingTypeProperties = struct {
    /// The configuration to add user-defined properties to enrich MQTT 5 messages.
    mqtt_5_configuration: ?Mqtt5Configuration,

    /// A list of searchable thing attribute names.
    searchable_attributes: ?[]const []const u8,

    /// The description of the thing type.
    thing_type_description: ?[]const u8,

    pub const json_field_names = .{
        .mqtt_5_configuration = "mqtt5Configuration",
        .searchable_attributes = "searchableAttributes",
        .thing_type_description = "thingTypeDescription",
    };
};
