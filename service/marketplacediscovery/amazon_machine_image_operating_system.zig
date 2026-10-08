/// Describes an operating system supported by an AMI fulfillment option.
pub const AmazonMachineImageOperatingSystem = struct {
    /// The operating system family, such as Linux or Windows.
    operating_system_family_name: []const u8,

    /// The specific operating system name, such as Amazon Linux 2 or Windows Server
    /// 2022.
    operating_system_name: []const u8,

    /// The version of the operating system.
    operating_system_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .operating_system_family_name = "operatingSystemFamilyName",
        .operating_system_name = "operatingSystemName",
        .operating_system_version = "operatingSystemVersion",
    };
};
