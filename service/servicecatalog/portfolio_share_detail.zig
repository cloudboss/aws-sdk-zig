const DescribePortfolioShareType = @import("describe_portfolio_share_type.zig").DescribePortfolioShareType;

/// Information about the portfolio share.
pub const PortfolioShareDetail = struct {
    /// Indicates whether the shared portfolio is imported by the recipient account.
    /// If the recipient is in an organization node, the share is automatically
    /// imported, and the field is always set to true.
    accepted: bool = false,

    /// The identifier of the recipient entity that received the portfolio share.
    /// The recipient entity can be one of the following:
    ///
    /// 1. An external account.
    ///
    /// 2. An organziation member account.
    ///
    /// 3. An organzational unit (OU).
    ///
    /// 4. The organization itself. (This shares with every account in the
    /// organization).
    principal_id: ?[]const u8,

    /// Indicates if `Principal` sharing is enabled or disabled for the portfolio
    /// share.
    share_principals: bool = false,

    /// Indicates whether TagOptions sharing is enabled or disabled for the
    /// portfolio share.
    share_tag_options: bool = false,

    /// The type of the portfolio share.
    type: ?DescribePortfolioShareType,

    pub const json_field_names = .{
        .accepted = "Accepted",
        .principal_id = "PrincipalId",
        .share_principals = "SharePrincipals",
        .share_tag_options = "ShareTagOptions",
        .type = "Type",
    };
};
