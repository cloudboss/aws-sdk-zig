const std = @import("std");

pub const ChangeServerLifeCycleStateSourceServerLifecycleState = enum {
    ready_for_test,
    ready_for_cutover,
    cutover,

    pub const json_field_names = .{
        .ready_for_test = "READY_FOR_TEST",
        .ready_for_cutover = "READY_FOR_CUTOVER",
        .cutover = "CUTOVER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready_for_test => "READY_FOR_TEST",
            .ready_for_cutover => "READY_FOR_CUTOVER",
            .cutover => "CUTOVER",
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
