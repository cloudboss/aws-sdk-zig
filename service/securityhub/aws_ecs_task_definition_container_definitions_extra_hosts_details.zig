/// A hostname and IP address mapping to append to the **/etc/hosts** file on
/// the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsExtraHostsDetails = struct {
    /// The hostname to use in the **/etc/hosts** entry.
    hostname: ?[]const u8 = null,

    /// The IP address to use in the **/etc/hosts** entry.
    ip_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .hostname = "Hostname",
        .ip_address = "IpAddress",
    };
};
