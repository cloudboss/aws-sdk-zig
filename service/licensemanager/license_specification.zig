/// Details for associating a license configuration with a resource.
pub const LicenseSpecification = struct {
    /// Scope of AMI associations. The possible value is `cross-account`.
    ami_association_scope: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: []const u8,

    pub const json_field_names = .{
        .ami_association_scope = "AmiAssociationScope",
        .license_configuration_arn = "LicenseConfigurationArn",
    };
};
