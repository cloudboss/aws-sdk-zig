const BillingEntity = @import("billing_entity.zig").BillingEntity;

/// The organization name providing Amazon Web Services services.
pub const Entity = struct {
    /// Helps you identify whether your invoices are for Amazon Web Services
    /// Marketplace or for purchases of other Amazon Web Services services.
    billing_entity: ?BillingEntity = null,

    /// The name of the entity that issues the Amazon Web Services invoice.
    invoicing_entity: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_entity = "BillingEntity",
        .invoicing_entity = "InvoicingEntity",
    };
};
