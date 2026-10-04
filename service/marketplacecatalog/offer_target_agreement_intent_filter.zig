const OfferTargetAgreementIntentString = @import("offer_target_agreement_intent_string.zig").OfferTargetAgreementIntentString;

/// Allows filtering on the `TargetAgreementIntent` of an offer.
pub const OfferTargetAgreementIntentFilter = struct {
    /// Allows filtering on the `TargetAgreementIntent` of an offer with list input.
    value_list: ?[]const OfferTargetAgreementIntentString = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
