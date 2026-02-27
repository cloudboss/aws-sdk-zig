/// Specifies the time format in the GS05 element (time) of the functional group
/// header. The following formats use 24-hour clock time:
///
/// * `HHMM` - Hours and minutes
/// * `HHMMSS` - Hours, minutes, and seconds
/// * `HHMMSSDD` - Hours, minutes, seconds, and decimal seconds
///
/// Where:
///
/// * `HH` - Hours (00-23)
/// * `MM` - Minutes (00-59)
/// * `SS` - Seconds (00-59)
/// * `DD` - Hundredths of seconds (00-99)
pub const X12GS05TimeFormat = enum {
    hhmm,
    hhmmss,
    hhmmssdd,

    pub const json_field_names = .{
        .hhmm = "HHMM",
        .hhmmss = "HHMMSS",
        .hhmmssdd = "HHMMSSDD",
    };
};
