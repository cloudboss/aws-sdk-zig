const std = @import("std");

pub const PostLaunchActionsDeploymentType = enum {
    test_and_cutover,
    cutover_only,
    test_only,

    pub const json_field_names = .{
        .test_and_cutover = "TEST_AND_CUTOVER",
        .cutover_only = "CUTOVER_ONLY",
        .test_only = "TEST_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .test_and_cutover => "TEST_AND_CUTOVER",
            .cutover_only => "CUTOVER_ONLY",
            .test_only => "TEST_ONLY",
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
