const ChileDocumentType = @import("chile_document_type.zig").ChileDocumentType;

/// Additional tax information associated with your TRN in Chile.
pub const ChileAdditionalInfo = struct {
    /// The business activity code of the taxpayer in Chile. This must be the
    /// activity code shown on your SII (Servicio de Impuestos Internos) tax
    /// profile. For the list of valid activity codes, see [SII activity
    /// codes](https://www.sii.cl/ayudas/ayudas_por_servicios/1956-codigos-1959.html).
    business_activity: ?[]const u8 = null,

    /// The type of tax document. For Chile, this can be `Invoice` or `Receipt`.
    document_type: ?ChileDocumentType = null,

    pub const json_field_names = .{
        .business_activity = "businessActivity",
        .document_type = "documentType",
    };
};
