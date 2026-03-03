const std = @import("std");

pub const WorkflowExport = enum {
    definition,
    readme,

    pub const json_field_names = .{
        .definition = "DEFINITION",
        .readme = "README",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .definition => "DEFINITION",
            .readme => "README",
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
