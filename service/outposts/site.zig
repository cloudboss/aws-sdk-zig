const aws = @import("aws");

const RackPhysicalProperties = @import("rack_physical_properties.zig").RackPhysicalProperties;

/// Information about a site.
pub const Site = struct {
    account_id: ?[]const u8,

    description: ?[]const u8,

    name: ?[]const u8,

    /// Notes about a site.
    notes: ?[]const u8,

    /// City where the hardware is installed and powered on.
    operating_address_city: ?[]const u8,

    /// The ISO-3166 two-letter country code where the hardware is installed and
    /// powered on.
    operating_address_country_code: ?[]const u8,

    /// State or region where the hardware is installed and powered on.
    operating_address_state_or_region: ?[]const u8,

    /// Information about the physical and logistical details for a rack at the
    /// site.
    rack_physical_properties: ?RackPhysicalProperties,

    site_arn: ?[]const u8,

    site_id: ?[]const u8,

    /// The site tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .description = "Description",
        .name = "Name",
        .notes = "Notes",
        .operating_address_city = "OperatingAddressCity",
        .operating_address_country_code = "OperatingAddressCountryCode",
        .operating_address_state_or_region = "OperatingAddressStateOrRegion",
        .rack_physical_properties = "RackPhysicalProperties",
        .site_arn = "SiteArn",
        .site_id = "SiteId",
        .tags = "Tags",
    };
};
