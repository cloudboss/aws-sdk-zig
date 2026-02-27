const MonthName = @import("month_name.zig").MonthName;

/// An enumeration of months used for scheduling maintenance windows.
pub const Month = struct {
    /// The name of the month.
    name: ?MonthName,

    pub const json_field_names = .{
        .name = "name",
    };
};
