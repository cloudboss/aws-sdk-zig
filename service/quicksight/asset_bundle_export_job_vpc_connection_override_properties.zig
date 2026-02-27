const AssetBundleExportJobVPCConnectionPropertyToOverride = @import("asset_bundle_export_job_vpc_connection_property_to_override.zig").AssetBundleExportJobVPCConnectionPropertyToOverride;

/// Controls how a specific `VPCConnection` resource is parameterized in the
/// outputted CloudFormation template.
pub const AssetBundleExportJobVPCConnectionOverrideProperties = struct {
    /// The ARN of the specific `VPCConnection` resource whose override properties
    /// are configured in this structure.
    arn: []const u8,

    /// A list of `VPCConnection` resource properties to generate variables for in
    /// the returned CloudFormation template.
    properties: []const AssetBundleExportJobVPCConnectionPropertyToOverride,

    pub const json_field_names = .{
        .arn = "Arn",
        .properties = "Properties",
    };
};
