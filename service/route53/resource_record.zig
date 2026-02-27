/// Information specific to the resource record.
///
/// If you're creating an alias resource record set, omit
/// `ResourceRecord`.
pub const ResourceRecord = struct {
    /// The current or new DNS record value, not to exceed 4,000 characters. In the
    /// case of a
    /// `DELETE` action, if the current value does not match the actual value, an
    /// error is returned. For descriptions about how to format `Value` for
    /// different
    /// record types, see [Supported DNS Resource
    /// Record
    /// Types](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/ResourceRecordTypes.html) in the *Amazon Route 53 Developer
    /// Guide*.
    ///
    /// You can specify more than one value for all record types except `CNAME` and
    /// `SOA`.
    ///
    /// If you're creating an alias resource record set, omit `Value`.
    value: []const u8,
};
