/// Defines the customer support available for the acceptors when they purchase
/// the software.
pub const SupportTerm = struct {
    /// The unique identifier for the term.
    id: ?[]const u8 = null,

    /// Free-text field about the refund policy description that will be shown to
    /// customers as is on the website and console.
    refund_policy: ?[]const u8 = null,

    /// Category of the term being updated.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .refund_policy = "refundPolicy",
        .@"type" = "type",
    };
};
