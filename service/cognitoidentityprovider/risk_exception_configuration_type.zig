/// Exceptions to the risk evaluation configuration, including always-allow and
/// always-block IP address ranges.
pub const RiskExceptionConfigurationType = struct {
    /// An always-block IP address list. Overrides the risk decision and always
    /// blocks
    /// authentication requests. This parameter is displayed and set in CIDR
    /// notation.
    blocked_ip_range_list: ?[]const []const u8 = null,

    /// An always-allow IP address list. Risk detection isn't performed on the IP
    /// addresses in
    /// this range list. This parameter is displayed and set in CIDR notation.
    skipped_ip_range_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .blocked_ip_range_list = "BlockedIPRangeList",
        .skipped_ip_range_list = "SkippedIPRangeList",
    };
};
