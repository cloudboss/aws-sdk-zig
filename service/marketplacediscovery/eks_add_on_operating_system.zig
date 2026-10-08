/// Describes an operating system supported by an EKS add-on fulfillment option.
pub const EksAddOnOperatingSystem = struct {
    /// The operating system family, such as Linux.
    operating_system_family_name: []const u8,

    /// The specific operating system name.
    operating_system_name: []const u8,

    pub const json_field_names = .{
        .operating_system_family_name = "operatingSystemFamilyName",
        .operating_system_name = "operatingSystemName",
    };
};
