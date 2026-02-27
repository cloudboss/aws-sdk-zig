/// Local TimeZone Detection method.
pub const LocalTimeZoneDetectionType = enum {
    zip_code,
    area_code,

    pub const json_field_names = .{
        .zip_code = "ZIP_CODE",
        .area_code = "AREA_CODE",
    };
};
