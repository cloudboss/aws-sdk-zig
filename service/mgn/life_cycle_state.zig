const std = @import("std");

pub const LifeCycleState = enum {
    stopped,
    not_ready,
    ready_for_test,
    testing,
    ready_for_cutover,
    cutting_over,
    cutover,
    disconnected,
    discovered,
    pending_installation,

    pub const json_field_names = .{
        .stopped = "STOPPED",
        .not_ready = "NOT_READY",
        .ready_for_test = "READY_FOR_TEST",
        .testing = "TESTING",
        .ready_for_cutover = "READY_FOR_CUTOVER",
        .cutting_over = "CUTTING_OVER",
        .cutover = "CUTOVER",
        .disconnected = "DISCONNECTED",
        .discovered = "DISCOVERED",
        .pending_installation = "PENDING_INSTALLATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stopped => "STOPPED",
            .not_ready => "NOT_READY",
            .ready_for_test => "READY_FOR_TEST",
            .testing => "TESTING",
            .ready_for_cutover => "READY_FOR_CUTOVER",
            .cutting_over => "CUTTING_OVER",
            .cutover => "CUTOVER",
            .disconnected => "DISCONNECTED",
            .discovered => "DISCOVERED",
            .pending_installation => "PENDING_INSTALLATION",
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
