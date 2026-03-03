const ConnectionTestingMethod = @import("connection_testing_method.zig").ConnectionTestingMethod;
const EinvoiceDeliveryAttachmentType = @import("einvoice_delivery_attachment_type.zig").EinvoiceDeliveryAttachmentType;
const EinvoiceDeliveryDocumentType = @import("einvoice_delivery_document_type.zig").EinvoiceDeliveryDocumentType;
const Protocol = @import("protocol.zig").Protocol;
const PurchaseOrderDataSource = @import("purchase_order_data_source.zig").PurchaseOrderDataSource;

/// Specifies the preferences for e-invoice delivery, including document types,
/// attachment types, and customization settings.
pub const EinvoiceDeliveryPreference = struct {
    /// The method to use for testing the connection to the procurement portal.
    connection_testing_method: ConnectionTestingMethod,

    /// The date when e-invoice delivery should be activated for this preference.
    einvoice_delivery_activation_date: i64,

    /// The types of attachments to include with the e-invoice delivery.
    einvoice_delivery_attachment_types: ?[]const EinvoiceDeliveryAttachmentType = null,

    /// The types of e-invoice documents to be delivered.
    einvoice_delivery_document_types: []const EinvoiceDeliveryDocumentType,

    /// The communication protocol to use for e-invoice delivery.
    protocol: Protocol,

    /// The sources of purchase order data to use for e-invoice generation and
    /// delivery.
    purchase_order_data_sources: []const PurchaseOrderDataSource,

    pub const json_field_names = .{
        .connection_testing_method = "ConnectionTestingMethod",
        .einvoice_delivery_activation_date = "EinvoiceDeliveryActivationDate",
        .einvoice_delivery_attachment_types = "EinvoiceDeliveryAttachmentTypes",
        .einvoice_delivery_document_types = "EinvoiceDeliveryDocumentTypes",
        .protocol = "Protocol",
        .purchase_order_data_sources = "PurchaseOrderDataSources",
    };
};
