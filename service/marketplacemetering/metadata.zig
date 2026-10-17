/// Metadata associated with a resolved customer. Includes the `AgreementId` of
/// the Amazon Web Services Marketplace agreement the customer accepted.
pub const Metadata = struct {
    /// The unique identifier of the Amazon Web Services Marketplace agreement the
    /// customer accepted. Use it to
    /// call Amazon Web Services Marketplace Agreement APIs.
    agreement_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agreement_id = "AgreementId",
    };
};
