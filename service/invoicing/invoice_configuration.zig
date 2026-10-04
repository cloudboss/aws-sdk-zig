const EinvoiceDeliveryAttachmentType = @import("einvoice_delivery_attachment_type.zig").EinvoiceDeliveryAttachmentType;
const EinvoiceDeliveryDocumentType = @import("einvoice_delivery_document_type.zig").EinvoiceDeliveryDocumentType;

/// Specifies the supported document types and attachment types for invoice
/// delivery to a procurement portal.
pub const InvoiceConfiguration = struct {
    /// The attachment types supported by the procurement portal for e-invoice
    /// delivery.
    attachment_types: ?[]const EinvoiceDeliveryAttachmentType = null,

    /// The e-invoice document types supported by the procurement portal.
    document_types: ?[]const EinvoiceDeliveryDocumentType = null,

    pub const json_field_names = .{
        .attachment_types = "AttachmentTypes",
        .document_types = "DocumentTypes",
    };
};
