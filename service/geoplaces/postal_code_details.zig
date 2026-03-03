const PostalAuthority = @import("postal_authority.zig").PostalAuthority;
const PostalCodeType = @import("postal_code_type.zig").PostalCodeType;
const UspsZip = @import("usps_zip.zig").UspsZip;
const UspsZipPlus4 = @import("usps_zip_plus_4.zig").UspsZipPlus4;

/// Contains details about the postal code of the place or result.
pub const PostalCodeDetails = struct {
    /// The postal authority or entity. This could be a governmental authority, a
    /// regulatory authority, or a designated postal operator.
    postal_authority: ?PostalAuthority = null,

    /// An alphanumeric string included in a postal address to facilitate mail
    /// sorting, such as post code, postcode, or ZIP code for which the result
    /// should possess.
    postal_code: ?[]const u8 = null,

    /// The postal code type.
    postal_code_type: ?PostalCodeType = null,

    /// The ZIP Classification Code, or in other words what type of postal code is
    /// it.
    usps_zip: ?UspsZip = null,

    /// The USPS ZIP+4 Record Type Code.
    usps_zip_plus_4: ?UspsZipPlus4 = null,

    pub const json_field_names = .{
        .postal_authority = "PostalAuthority",
        .postal_code = "PostalCode",
        .postal_code_type = "PostalCodeType",
        .usps_zip = "UspsZip",
        .usps_zip_plus_4 = "UspsZipPlus4",
    };
};
