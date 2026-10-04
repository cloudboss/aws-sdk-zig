const ResourceRecord = @import("resource_record.zig").ResourceRecord;

/// Contains the CNAME record that you must add to your DNS configuration to
/// validate domain ownership using DNS validation.
pub const DnsValidationChallenge = struct {
    /// The CNAME record that ACM creates for DNS validation. Add this record to
    /// your DNS configuration to prove that you own or control the domain.
    resource_record: ?ResourceRecord = null,

    pub const json_field_names = .{
        .resource_record = "ResourceRecord",
    };
};
