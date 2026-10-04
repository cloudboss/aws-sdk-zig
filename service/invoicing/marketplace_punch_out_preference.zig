/// Represents the Marketplace PunchOut configuration for a procurement portal
/// preference.
pub const MarketplacePunchOutPreference = struct {
    /// The URL that buyers are redirected to for approval requests in the
    /// procurement portal. This is only supported for Coupa. When provided together
    /// with the procurement portal instance endpoint, its host must match the host
    /// of that endpoint.
    approval_request_redirect_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_request_redirect_url = "ApprovalRequestRedirectUrl",
    };
};
