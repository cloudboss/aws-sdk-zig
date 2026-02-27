const Reason = @import("reason.zig").Reason;

/// Contains information on suspicious IP addresses identified as indicators of
/// compromise. This indicator is derived from Amazon Web Services threat
/// intelligence.
pub const FlaggedIpAddressDetail = struct {
    /// IP address of the suspicious entity.
    ip_address: ?[]const u8,

    /// Details the reason the IP address was flagged as suspicious.
    reason: ?Reason,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .reason = "Reason",
    };
};
