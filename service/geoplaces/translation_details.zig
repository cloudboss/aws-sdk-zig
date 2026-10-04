const AdminNames = @import("admin_names.zig").AdminNames;

/// Translation details for the address, including alternative names and
/// translations in available languages.
pub const TranslationDetails = struct {
    /// A list of administrative names and translations for the district address
    /// component.
    district: ?[]const AdminNames = null,

    /// A list of administrative names and translations for the locality address
    /// component.
    locality: ?[]const AdminNames = null,

    /// A list of administrative names and translations for the region address
    /// component.
    region: ?[]const AdminNames = null,

    /// A list of administrative names and translations for the sub-region address
    /// component.
    sub_region: ?[]const AdminNames = null,

    pub const json_field_names = .{
        .district = "District",
        .locality = "Locality",
        .region = "Region",
        .sub_region = "SubRegion",
    };
};
