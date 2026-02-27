/// The organization name providing Amazon Web Services services.
pub const Entity = struct {
    /// The name of the entity that issues the Amazon Web Services invoice.
    invoicing_entity: ?[]const u8,

    pub const json_field_names = .{
        .invoicing_entity = "InvoicingEntity",
    };
};
