const EinvoiceDeliveryDocumentType = @import("einvoice_delivery_document_type.zig").EinvoiceDeliveryDocumentType;
const PurchaseOrderDataSourceType = @import("purchase_order_data_source_type.zig").PurchaseOrderDataSourceType;

/// Specifies the source configuration for retrieving purchase order data.
pub const PurchaseOrderDataSource = struct {
    /// The type of e-invoice document that requires purchase order data.
    einvoice_delivery_document_type: ?EinvoiceDeliveryDocumentType = null,

    /// The type of source for purchase order data.
    purchase_order_data_source_type: ?PurchaseOrderDataSourceType = null,

    pub const json_field_names = .{
        .einvoice_delivery_document_type = "EinvoiceDeliveryDocumentType",
        .purchase_order_data_source_type = "PurchaseOrderDataSourceType",
    };
};
