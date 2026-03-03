/// Represents additional options for correct interpretation of datetime
/// parameters used in
/// the Amazon S3 path of a dataset.
pub const DatetimeOptions = struct {
    /// Required option, that defines the datetime format used for a date parameter
    /// in the
    /// Amazon S3 path. Should use only supported datetime specifiers and separation
    /// characters, all
    /// literal a-z or A-Z characters should be escaped with single quotes. E.g.
    /// "MM.dd.yyyy-'at'-HH:mm".
    format: []const u8,

    /// Optional value for a non-US locale code, needed for correct interpretation
    /// of some date formats.
    locale_code: ?[]const u8 = null,

    /// Optional value for a timezone offset of the datetime parameter value in the
    /// Amazon S3
    /// path. Shouldn't be used if Format for this parameter includes timezone
    /// fields.
    /// If no offset specified, UTC is assumed.
    timezone_offset: ?[]const u8 = null,

    pub const json_field_names = .{
        .format = "Format",
        .locale_code = "LocaleCode",
        .timezone_offset = "TimezoneOffset",
    };
};
