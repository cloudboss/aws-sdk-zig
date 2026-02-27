const WickrAwsNetworks = @import("wickr_aws_networks.zig").WickrAwsNetworks;
const PermittedWickrEnterpriseNetwork = @import("permitted_wickr_enterprise_network.zig").PermittedWickrEnterpriseNetwork;

/// Contains the security group configuration settings that can be specified
/// when creating or updating a security group. This is a subset of
/// SecurityGroupSettings containing only the modifiable federation and security
/// settings.
pub const SecurityGroupSettingsRequest = struct {
    /// Guest users let you work with people outside your organization that only
    /// have limited access to Wickr. Only valid when federationMode is set to
    /// Global.
    enable_guest_federation: ?bool,

    /// Enables restricted global federation to limit communication to specific
    /// permitted networks only. Requires globalFederation to be enabled.
    enable_restricted_global_federation: ?bool,

    /// The local federation mode. Values: 0 (none), 1 (federated - all networks), 2
    /// (restricted - only permitted networks).
    federation_mode: ?i32,

    /// Allow users to securely federate with all Amazon Web Services Wickr networks
    /// and Amazon Web Services Enterprise networks.
    global_federation: ?bool,

    /// The number of failed password attempts before a user account is locked out.
    lockout_threshold: ?i32,

    /// A list of network IDs that are permitted for local federation when
    /// federation mode is set to restricted.
    permitted_networks: ?[]const []const u8,

    /// A list of permitted Amazon Web Services Wickr networks for restricted global
    /// federation.
    permitted_wickr_aws_networks: ?[]const WickrAwsNetworks,

    /// A list of permitted Wickr Enterprise networks for restricted global
    /// federation.
    permitted_wickr_enterprise_networks: ?[]const PermittedWickrEnterpriseNetwork,

    pub const json_field_names = .{
        .enable_guest_federation = "enableGuestFederation",
        .enable_restricted_global_federation = "enableRestrictedGlobalFederation",
        .federation_mode = "federationMode",
        .global_federation = "globalFederation",
        .lockout_threshold = "lockoutThreshold",
        .permitted_networks = "permittedNetworks",
        .permitted_wickr_aws_networks = "permittedWickrAwsNetworks",
        .permitted_wickr_enterprise_networks = "permittedWickrEnterpriseNetworks",
    };
};
