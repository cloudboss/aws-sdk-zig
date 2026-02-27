/// Defines a custom ASN.1 X.400 `GeneralName` using an object identifier (OID)
/// and value. The OID must satisfy the regular expression shown below. For more
/// information, see NIST's definition of [Object Identifier
/// (OID)](https://csrc.nist.gov/glossary/term/Object_Identifier).
pub const OtherName = struct {
    /// Specifies an OID.
    type_id: []const u8,

    /// Specifies an OID value.
    value: []const u8,

    pub const json_field_names = .{
        .type_id = "TypeId",
        .value = "Value",
    };
};
