const ProvisionedResourceEngine = @import("provisioned_resource_engine.zig").ProvisionedResourceEngine;

/// Detail data for a provisioned resource.
pub const ProvisionedResource = struct {
    /// The provisioned resource identifier.
    identifier: ?[]const u8,

    /// The provisioned resource name.
    name: ?[]const u8,

    /// The resource provisioning engine. At this time, `CLOUDFORMATION` can be used
    /// for Amazon Web Services-managed provisioning, and `TERRAFORM` can
    /// be used for self-managed provisioning.
    ///
    /// For more information, see [Self-managed
    /// provisioning](https://docs.aws.amazon.com/proton/latest/userguide/ag-works-prov-methods.html#ag-works-prov-methods-self) in the *Proton User Guide*.
    provisioning_engine: ?ProvisionedResourceEngine,

    pub const json_field_names = .{
        .identifier = "identifier",
        .name = "name",
        .provisioning_engine = "provisioningEngine",
    };
};
