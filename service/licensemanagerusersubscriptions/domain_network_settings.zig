/// Contains network settings for the Active Directory domain.
pub const DomainNetworkSettings = struct {
    /// Contains a list of subnets that apply for the Active Directory domain.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .subnets = "Subnets",
    };
};
