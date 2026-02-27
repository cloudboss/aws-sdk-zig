const ResourceAttributeType = @import("resource_attribute_type.zig").ResourceAttributeType;

/// Attribute associated with a resource.
///
/// Note the corresponding format required per type listed below:
///
/// **IPV4**
///
/// `x.x.x.x`
///
/// *where x is an integer in the range [0,255]*
///
/// **IPV6**
///
/// `y : y : y : y : y : y : y : y`
///
/// *where y is a hexadecimal between 0 and FFFF. [0,
/// FFFF]*
///
/// **MAC_ADDRESS**
///
/// `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`
///
/// **FQDN**
///
/// `^[^<>{}\\\\/?,=\\p{Cntrl}]{1,256}$`
pub const ResourceAttribute = struct {
    /// Type of resource.
    type: ResourceAttributeType,

    /// Value of the resource type.
    value: []const u8,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
