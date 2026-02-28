/// Provides details about the CNAME record that is added to the DNS database
/// for domain
/// validation.
pub const AwsCertificateManagerCertificateResourceRecord = struct {
    /// The name of the resource.
    name: ?[]const u8,

    /// The type of resource.
    @"type": ?[]const u8,

    /// The value of the resource.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
        .value = "Value",
    };
};
