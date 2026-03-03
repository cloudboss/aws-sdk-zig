/// Specifies the X.509 extension information for a certificate.
///
/// Extensions present in `CustomExtensions` follow the `ApiPassthrough`
/// [template
/// rules](https://docs.aws.amazon.com/privateca/latest/userguide/UsingTemplates.html#template-order-of-operations).
pub const CustomExtension = struct {
    /// Specifies the critical flag of the X.509 extension.
    critical: ?bool = null,

    /// Specifies the object identifier (OID) of the X.509 extension. For more
    /// information, see the [Global OID reference
    /// database.](https://oidref.com/2.5.29)
    object_identifier: []const u8,

    /// Specifies the base64-encoded value of the X.509 extension.
    value: []const u8,

    pub const json_field_names = .{
        .critical = "Critical",
        .object_identifier = "ObjectIdentifier",
        .value = "Value",
    };
};
