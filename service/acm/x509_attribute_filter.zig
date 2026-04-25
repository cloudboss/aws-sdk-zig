const ExtendedKeyUsageName = @import("extended_key_usage_name.zig").ExtendedKeyUsageName;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;
const KeyUsageName = @import("key_usage_name.zig").KeyUsageName;
const TimestampRange = @import("timestamp_range.zig").TimestampRange;
const SubjectFilter = @import("subject_filter.zig").SubjectFilter;
const SubjectAlternativeNameFilter = @import("subject_alternative_name_filter.zig").SubjectAlternativeNameFilter;

/// Filters certificates by X.509 attributes.
pub const X509AttributeFilter = union(enum) {
    /// Filter by extended key usage.
    extended_key_usage: ?ExtendedKeyUsageName,
    /// Filter by key algorithm.
    key_algorithm: ?KeyAlgorithm,
    /// Filter by key usage.
    key_usage: ?KeyUsageName,
    /// Filter by certificate expiration date. The start date is inclusive.
    not_after: ?TimestampRange,
    /// Filter by certificate validity start date. The start date is inclusive.
    not_before: ?TimestampRange,
    /// Filter by serial number.
    serial_number: ?[]const u8,
    /// Filter by certificate subject.
    subject: ?SubjectFilter,
    /// Filter by subject alternative names.
    subject_alternative_name: ?SubjectAlternativeNameFilter,

    pub const json_field_names = .{
        .extended_key_usage = "ExtendedKeyUsage",
        .key_algorithm = "KeyAlgorithm",
        .key_usage = "KeyUsage",
        .not_after = "NotAfter",
        .not_before = "NotBefore",
        .serial_number = "SerialNumber",
        .subject = "Subject",
        .subject_alternative_name = "SubjectAlternativeName",
    };
};
