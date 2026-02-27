/// High-level information about a TLS inspection configuration, returned by
/// `ListTLSInspectionConfigurations`. You can use the information provided in
/// the metadata to retrieve and manage a TLS configuration.
pub const TLSInspectionConfigurationMetadata = struct {
    /// The Amazon Resource Name (ARN) of the TLS inspection configuration.
    arn: ?[]const u8,

    /// The descriptive name of the TLS inspection configuration. You can't change
    /// the name of a TLS inspection configuration after you create it.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
