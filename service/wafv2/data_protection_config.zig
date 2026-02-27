const DataProtection = @import("data_protection.zig").DataProtection;

/// Specifies data protection to apply to the web request data for the web ACL.
/// This is a web ACL level data protection option.
///
/// The data protection that you configure for the web ACL alters the data
/// that's available for any other data collection activity,
/// including your WAF logging destinations, web ACL request sampling, and
/// Amazon Security Lake data collection and management. Your other option for
/// data protection is in the logging configuration, which only affects logging.
///
/// This is part of the data protection configuration for a web ACL.
pub const DataProtectionConfig = struct {
    /// An array of data protection configurations for specific web request field
    /// types. This is defined for each
    /// web ACL. WAF applies the specified protection to all web requests that the
    /// web ACL inspects.
    data_protections: []const DataProtection,

    pub const json_field_names = .{
        .data_protections = "DataProtections",
    };
};
