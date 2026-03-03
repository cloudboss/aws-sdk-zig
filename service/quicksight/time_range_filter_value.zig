const RollingDateConfiguration = @import("rolling_date_configuration.zig").RollingDateConfiguration;

/// The value of a time range filter.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const TimeRangeFilterValue = struct {
    /// The parameter type input value.
    parameter: ?[]const u8 = null,

    /// The rolling date input value.
    rolling_date: ?RollingDateConfiguration = null,

    /// The static input value.
    static_value: ?i64 = null,

    pub const json_field_names = .{
        .parameter = "Parameter",
        .rolling_date = "RollingDate",
        .static_value = "StaticValue",
    };
};
