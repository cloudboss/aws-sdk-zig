/// A summary view of a partner account containing basic information for listing
/// purposes.
pub const PartnerSummary = struct {
    /// The Amazon Resource Name (ARN) of the partner account.
    arn: []const u8,

    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// The timestamp when the partner account was created.
    created_at: i64,

    /// The unique identifier of the partner account.
    id: []const u8,

    /// The legal name of the partner organization.
    legal_name: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .created_at = "CreatedAt",
        .id = "Id",
        .legal_name = "LegalName",
    };
};
