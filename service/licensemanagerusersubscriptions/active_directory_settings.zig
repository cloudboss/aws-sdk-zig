const CredentialsProvider = @import("credentials_provider.zig").CredentialsProvider;
const DomainNetworkSettings = @import("domain_network_settings.zig").DomainNetworkSettings;

/// Contains network access and credential details that are needed for user
/// administration in the Active Directory.
pub const ActiveDirectorySettings = struct {
    /// Points to the `CredentialsProvider` resource that contains information about
    /// the credential provider for user administration.
    domain_credentials_provider: ?CredentialsProvider,

    /// A list of domain IPv4 addresses that are used for the Active Directory.
    domain_ipv_4_list: ?[]const []const u8,

    /// A list of domain IPv6 addresses that are used for the Active Directory.
    domain_ipv_6_list: ?[]const []const u8,

    /// The domain name for the Active Directory.
    domain_name: ?[]const u8,

    /// The `DomainNetworkSettings` resource contains an array of subnets that apply
    /// for the Active Directory.
    domain_network_settings: ?DomainNetworkSettings,

    pub const json_field_names = .{
        .domain_credentials_provider = "DomainCredentialsProvider",
        .domain_ipv_4_list = "DomainIpv4List",
        .domain_ipv_6_list = "DomainIpv6List",
        .domain_name = "DomainName",
        .domain_network_settings = "DomainNetworkSettings",
    };
};
