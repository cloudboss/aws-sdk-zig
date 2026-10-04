const DnsPrevalidationOptions = @import("dns_prevalidation_options.zig").DnsPrevalidationOptions;

/// Specifies prevalidation options for domain validation.
pub const PrevalidationOptions = union(enum) {
    /// DNS-based prevalidation options.
    dns_prevalidation: ?DnsPrevalidationOptions,

    pub const json_field_names = .{
        .dns_prevalidation = "DnsPrevalidation",
    };
};
