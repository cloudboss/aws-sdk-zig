/// The entity responsible for issuing the invoice.
pub const InvoicingEntity = struct {
    /// The branch where the issuing entity is operating from.
    branch_name: ?[]const u8 = null,

    /// Legal name of the entity issuing the invoice.
    legal_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .legal_name = "legalName",
    };
};
