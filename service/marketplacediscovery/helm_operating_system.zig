/// Describes an operating system supported by a Helm chart fulfillment option.
pub const HelmOperatingSystem = struct {
    /// The operating system family, such as Linux.
    operating_system_family_name: []const u8,

    /// The specific operating system name.
    operating_system_name: []const u8,

    pub const json_field_names = .{
        .operating_system_family_name = "operatingSystemFamilyName",
        .operating_system_name = "operatingSystemName",
    };
};
