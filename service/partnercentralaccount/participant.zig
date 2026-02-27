const AccountSummary = @import("account_summary.zig").AccountSummary;
const PartnerProfileSummary = @import("partner_profile_summary.zig").PartnerProfileSummary;
const SellerProfileSummary = @import("seller_profile_summary.zig").SellerProfileSummary;

/// Represents a participant in a partner connection, containing their profile
/// and account information.
pub const Participant = union(enum) {
    /// The AWS account information for the participant.
    account: ?AccountSummary,
    /// The partner profile information for the participant.
    partner_profile: ?PartnerProfileSummary,
    /// The seller profile information for the participant.
    seller_profile: ?SellerProfileSummary,

    pub const json_field_names = .{
        .account = "Account",
        .partner_profile = "PartnerProfile",
        .seller_profile = "SellerProfile",
    };
};
