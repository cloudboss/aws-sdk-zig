const CertificateFilter = @import("certificate_filter.zig").CertificateFilter;

/// A filter statement used to search for certificates. Can contain AND, OR, NOT
/// logical operators or a single filter.
pub const CertificateFilterStatement = union(enum) {
    /// A list of filter statements that must all be true.
    @"and": ?[]const CertificateFilterStatement,
    /// A single certificate filter.
    filter: ?CertificateFilter,
    /// A filter statement that must not be true.
    not: ?CertificateFilterStatement,
    /// A list of filter statements where at least one must be true.
    @"or": ?[]const CertificateFilterStatement,

    pub const json_field_names = .{
        .@"and" = "And",
        .filter = "Filter",
        .not = "Not",
        .@"or" = "Or",
    };
};
