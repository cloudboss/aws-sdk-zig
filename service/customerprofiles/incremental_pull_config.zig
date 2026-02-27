/// Specifies the configuration used when importing incremental records from the
/// source.
pub const IncrementalPullConfig = struct {
    /// A field that specifies the date time or timestamp field as the criteria to
    /// use when
    /// importing incremental records from the source.
    datetime_type_field_name: ?[]const u8,

    pub const json_field_names = .{
        .datetime_type_field_name = "DatetimeTypeFieldName",
    };
};
