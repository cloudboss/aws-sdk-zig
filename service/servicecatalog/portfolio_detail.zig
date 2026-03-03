/// Information about a portfolio.
pub const PortfolioDetail = struct {
    /// The ARN assigned to the portfolio.
    arn: ?[]const u8 = null,

    /// The UTC time stamp of the creation time.
    created_time: ?i64 = null,

    /// The description of the portfolio.
    description: ?[]const u8 = null,

    /// The name to use for display purposes.
    display_name: ?[]const u8 = null,

    /// The portfolio identifier.
    id: ?[]const u8 = null,

    /// The name of the portfolio provider.
    provider_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .created_time = "CreatedTime",
        .description = "Description",
        .display_name = "DisplayName",
        .id = "Id",
        .provider_name = "ProviderName",
    };
};
