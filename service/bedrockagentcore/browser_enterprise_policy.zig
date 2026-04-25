const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const BrowserEnterprisePolicyType = @import("browser_enterprise_policy_type.zig").BrowserEnterprisePolicyType;

/// Browser enterprise policy configuration.
pub const BrowserEnterprisePolicy = struct {
    /// The location of the enterprise policy file.
    location: ResourceLocation,

    /// The enterprise policy type. See BrowserEnterprisePolicyType.
    @"type": ?BrowserEnterprisePolicyType = null,

    pub const json_field_names = .{
        .location = "location",
        .@"type" = "type",
    };
};
