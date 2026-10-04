const std = @import("std");

pub const VpcProvisioningStrategy = enum {
    create_new,
    use_existing,

    pub const json_field_names = .{
        .create_new = "CREATE_NEW",
        .use_existing = "USE_EXISTING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_new => "CREATE_NEW",
            .use_existing => "USE_EXISTING",
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
