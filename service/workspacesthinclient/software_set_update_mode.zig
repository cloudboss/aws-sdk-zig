const std = @import("std");

pub const SoftwareSetUpdateMode = enum {
    use_latest,
    use_desired,

    pub const json_field_names = .{
        .use_latest = "USE_LATEST",
        .use_desired = "USE_DESIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .use_latest => "USE_LATEST",
            .use_desired => "USE_DESIRED",
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
