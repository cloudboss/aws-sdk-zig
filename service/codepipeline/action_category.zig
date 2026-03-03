const std = @import("std");

pub const ActionCategory = enum {
    source,
    build,
    deploy,
    @"test",
    invoke,
    approval,
    compute,

    pub const json_field_names = .{
        .source = "Source",
        .build = "Build",
        .deploy = "Deploy",
        .@"test" = "Test",
        .invoke = "Invoke",
        .approval = "Approval",
        .compute = "Compute",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source => "Source",
            .build => "Build",
            .deploy => "Deploy",
            .@"test" => "Test",
            .invoke => "Invoke",
            .approval => "Approval",
            .compute => "Compute",
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
