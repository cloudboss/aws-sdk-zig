/// The Amazon Route 53 record set.
pub const Route53ResourceRecordSet = struct {
    /// The Amazon Route 53 record set identifier.
    record_set_identifier: ?[]const u8,

    /// The Amazon Route 53 record set Region.
    region: ?[]const u8,

    pub const json_field_names = .{
        .record_set_identifier = "recordSetIdentifier",
        .region = "region",
    };
};
