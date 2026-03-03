/// Information about a prefix list association with a core network.
pub const PrefixListAssociation = struct {
    /// The core network id in the association.
    core_network_id: ?[]const u8 = null,

    /// The alias of the prefix list in the association.
    prefix_list_alias: ?[]const u8 = null,

    /// The ARN of the prefix list in the association.
    prefix_list_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .core_network_id = "CoreNetworkId",
        .prefix_list_alias = "PrefixListAlias",
        .prefix_list_arn = "PrefixListArn",
    };
};
