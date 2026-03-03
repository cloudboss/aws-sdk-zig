const AttributePayload = @import("attribute_payload.zig").AttributePayload;

/// Thing group properties.
pub const ThingGroupProperties = struct {
    /// The thing group attributes in JSON format.
    attribute_payload: ?AttributePayload = null,

    /// The thing group description.
    thing_group_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_payload = "attributePayload",
        .thing_group_description = "thingGroupDescription",
    };
};
