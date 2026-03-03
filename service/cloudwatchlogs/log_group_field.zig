/// The fields contained in log events found by a `GetLogGroupFields` operation,
/// along with the percentage of queried log events in which each field appears.
pub const LogGroupField = struct {
    /// The name of a log field.
    name: ?[]const u8 = null,

    /// The percentage of log events queried that contained the field.
    percent: i32 = 0,

    pub const json_field_names = .{
        .name = "name",
        .percent = "percent",
    };
};
