/// Details specific to a registered Azure DevOps service.
pub const RegisteredAzureDevOpsServiceDetails = struct {
    /// The Azure DevOps Organization name associated with the service.
    organization_name: []const u8,

    pub const json_field_names = .{
        .organization_name = "organizationName",
    };
};
