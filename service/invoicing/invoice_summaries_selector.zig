const ListInvoiceSummariesResourceType = @import("list_invoice_summaries_resource_type.zig").ListInvoiceSummariesResourceType;

/// Specifies the invoice summary.
pub const InvoiceSummariesSelector = struct {
    /// The query identifier type (`INVOICE_ID` or `ACCOUNT_ID`).
    resource_type: ListInvoiceSummariesResourceType,

    /// The value of the query identifier.
    value: []const u8,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .value = "Value",
    };
};
