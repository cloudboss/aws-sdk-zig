/// Information about the virtual router.
pub const RouterType = struct {
    /// The virtual interface router platform.
    platform: ?[]const u8 = null,

    /// Identifies the router by a combination of vendor, platform, and software
    /// version. For example, `CiscoSystemsInc-2900SeriesRouters-IOS124`.
    router_type_identifier: ?[]const u8 = null,

    /// The router software.
    software: ?[]const u8 = null,

    /// The vendor for the virtual interface's router.
    vendor: ?[]const u8 = null,

    /// The template for the virtual interface's router.
    xslt_template_name: ?[]const u8 = null,

    /// The MAC Security (MACsec) template for the virtual interface's router.
    xslt_template_name_for_mac_sec: ?[]const u8 = null,

    pub const json_field_names = .{
        .platform = "platform",
        .router_type_identifier = "routerTypeIdentifier",
        .software = "software",
        .vendor = "vendor",
        .xslt_template_name = "xsltTemplateName",
        .xslt_template_name_for_mac_sec = "xsltTemplateNameForMacSec",
    };
};
