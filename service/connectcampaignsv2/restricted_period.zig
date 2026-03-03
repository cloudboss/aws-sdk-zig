/// Restricted period
pub const RestrictedPeriod = struct {
    end_date: []const u8,

    name: ?[]const u8 = null,

    start_date: []const u8,

    pub const json_field_names = .{
        .end_date = "endDate",
        .name = "name",
        .start_date = "startDate",
    };
};
