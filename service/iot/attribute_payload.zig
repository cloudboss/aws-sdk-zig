const aws = @import("aws");

/// The attribute payload.
pub const AttributePayload = struct {
    /// A JSON string containing up to three key-value pair in JSON format. For
    /// example:
    ///
    /// `{\"attributes\":{\"string1\":\"string2\"}}`
    attributes: ?[]const aws.map.StringMapEntry,

    /// Specifies whether the list of attributes provided in the `AttributePayload`
    /// is merged with
    /// the attributes stored in the registry, instead of overwriting them.
    ///
    /// To remove an attribute, call `UpdateThing` with an empty attribute value.
    ///
    /// The `merge` attribute is only valid when calling `UpdateThing` or
    /// `UpdateThingGroup`.
    merge: bool = false,

    pub const json_field_names = .{
        .attributes = "attributes",
        .merge = "merge",
    };
};
