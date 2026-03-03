const std = @import("std");

/// The status of a predictive inbox placement test. If the status is
/// `IN_PROGRESS`, then the predictive inbox placement test is
/// currently running. Predictive inbox placement tests are usually complete
/// within 24 hours of creating the test.
/// If the status is `COMPLETE`, then the test is finished, and you can use the
/// `GetDeliverabilityTestReport` operation to view the results of the
/// test.
pub const DeliverabilityTestStatus = enum {
    in_progress,
    completed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .completed => "COMPLETED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
