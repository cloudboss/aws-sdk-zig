const DnsNameFilter = @import("dns_name_filter.zig").DnsNameFilter;

/// Filters certificates by subject alternative name attributes.
pub const SubjectAlternativeNameFilter = union(enum) {
    /// Filter by DNS name in subject alternative names.
    dns_name: ?DnsNameFilter,

    pub const json_field_names = .{
        .dns_name = "DnsName",
    };
};
