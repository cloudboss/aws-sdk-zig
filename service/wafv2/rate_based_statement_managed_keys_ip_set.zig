const IPAddressVersion = @import("ip_address_version.zig").IPAddressVersion;

/// The set of IP addresses that are currently blocked for a RateBasedStatement.
/// This is only available for rate-based rules
/// that aggregate on just the IP address, with the `AggregateKeyType` set to
/// `IP` or `FORWARDED_IP`.
///
/// A rate-based rule applies its rule action to requests from IP addresses that
/// are in the rule's managed keys list and that match the rule's scope-down
/// statement. When a rule has no scope-down statement, it applies the action to
/// all requests from the IP addresses that are in the list. The rule applies
/// its rule action to rate limit the matching requests. The action is usually
/// Block but it can be any valid rule action except for Allow.
///
/// The maximum number of IP addresses that can be rate limited by a single
/// rate-based rule instance is 10,000. If more than 10,000 addresses exceed the
/// rate limit, WAF limits those with the highest rates.
pub const RateBasedStatementManagedKeysIPSet = struct {
    /// The IP addresses that are currently blocked.
    addresses: ?[]const []const u8 = null,

    /// The version of the IP addresses, either `IPV4` or `IPV6`.
    ip_address_version: ?IPAddressVersion = null,

    pub const json_field_names = .{
        .addresses = "Addresses",
        .ip_address_version = "IPAddressVersion",
    };
};
