const ResourceAttribute = @import("resource_attribute.zig").ResourceAttribute;
const RequiresRecreation = @import("requires_recreation.zig").RequiresRecreation;

/// Information about a change to a resource attribute.
pub const ResourceTargetDefinition = struct {
    /// The attribute to be changed.
    attribute: ?ResourceAttribute,

    /// If the attribute is `Properties`, the value is the name of the property.
    /// Otherwise, the value is null.
    name: ?[]const u8,

    /// If the attribute is `Properties`, indicates whether a change to this
    /// property
    /// causes the resource to be re-created.
    requires_recreation: ?RequiresRecreation,

    pub const json_field_names = .{
        .attribute = "Attribute",
        .name = "Name",
        .requires_recreation = "RequiresRecreation",
    };
};
