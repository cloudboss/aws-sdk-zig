/// Allows filtering on the `TargetAgreementId` of an offer.
pub const OfferTargetAgreementIdFilter = struct {
    /// Allows filtering on the `TargetAgreementId` of an offer with list input.
    value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
