/// The entity that issues the AWS invoice.
pub const InvoicingEntity = struct {
    /// The branch name of the invoicing entity.
    branch_name: ?[]const u8 = null,

    /// The legal name of the invoicing entity.
    legal_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .legal_name = "legalName",
    };
};
