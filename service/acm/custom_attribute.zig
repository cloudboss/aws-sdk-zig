/// Defines the X.500 relative distinguished name (RDN).
pub const CustomAttribute = struct {
    /// Specifies the object identifier (OID) of the attribute type of the relative
    /// distinguished name (RDN).
    object_identifier: ?[]const u8 = null,

    /// Specifies the attribute value of relative distinguished name (RDN).
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
        .value = "Value",
    };
};
