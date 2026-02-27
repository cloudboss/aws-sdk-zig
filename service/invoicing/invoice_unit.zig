const InvoiceUnitRule = @import("invoice_unit_rule.zig").InvoiceUnitRule;

/// An invoice unit is a set of mutually exclusive accounts that correspond to
/// your business entity. Invoice units allow you separate Amazon Web Services
/// account costs and configures your invoice for each business entity going
/// forward.
pub const InvoiceUnit = struct {
    /// The assigned description for an invoice unit. This information can't be
    /// modified or deleted.
    description: ?[]const u8,

    /// The account that receives invoices related to the invoice unit.
    invoice_receiver: ?[]const u8,

    /// ARN to identify an invoice unit. This information can't be modified or
    /// deleted.
    invoice_unit_arn: ?[]const u8,

    /// The last time the invoice unit was updated. This is important to determine
    /// the version of invoice unit configuration used to create the invoices. Any
    /// invoice created after this modified time will use this invoice unit
    /// configuration.
    last_modified: ?i64,

    /// A unique name that is distinctive within your Amazon Web Services.
    name: ?[]const u8,

    /// An `InvoiceUnitRule` object used the categorize invoice units.
    rule: ?InvoiceUnitRule,

    /// Whether the invoice unit based tax inheritance is/ should be enabled or
    /// disabled.
    tax_inheritance_disabled: ?bool,

    pub const json_field_names = .{
        .description = "Description",
        .invoice_receiver = "InvoiceReceiver",
        .invoice_unit_arn = "InvoiceUnitArn",
        .last_modified = "LastModified",
        .name = "Name",
        .rule = "Rule",
        .tax_inheritance_disabled = "TaxInheritanceDisabled",
    };
};
