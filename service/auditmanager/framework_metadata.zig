/// The metadata of a framework, such as the name, ID, or description.
pub const FrameworkMetadata = struct {
    /// The compliance standard that's associated with the framework. For example,
    /// this could
    /// be PCI DSS or HIPAA.
    compliance_type: ?[]const u8,

    /// The description of the framework.
    description: ?[]const u8,

    /// The logo that's associated with the framework.
    logo: ?[]const u8,

    /// The name of the framework.
    name: ?[]const u8,

    pub const json_field_names = .{
        .compliance_type = "complianceType",
        .description = "description",
        .logo = "logo",
        .name = "name",
    };
};
