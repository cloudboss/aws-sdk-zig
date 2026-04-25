/// Defines a custom ASN.1 X.400 `GeneralName` using an object identifier (OID)
/// and value. For more information, see NIST's definition of [Object Identifier
/// (OID)](https://csrc.nist.gov/glossary/term/Object_Identifier).
pub const OtherName = struct {
    /// Specifies an OID.
    object_identifier: ?[]const u8 = null,

    /// Specifies an OID value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
        .value = "Value",
    };
};
