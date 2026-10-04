const DnsPrevalidationDetails = @import("dns_prevalidation_details.zig").DnsPrevalidationDetails;

/// Contains details about the prevalidation configuration.
pub const PrevalidationDetails = union(enum) {
    /// DNS-based prevalidation details.
    dns_prevalidation: ?DnsPrevalidationDetails,

    pub const json_field_names = .{
        .dns_prevalidation = "DnsPrevalidation",
    };
};
