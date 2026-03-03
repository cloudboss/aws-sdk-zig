const std = @import("std");

pub const ResourceConfigurationType = enum {
    /// Resource Configuration of type GROUP
    group,
    /// Resource Configuration of type CHILD
    child,
    /// Resource Configuration of type SINGLE
    single,
    /// Resource Configuration of type ARN
    arn,

    pub const json_field_names = .{
        .group = "GROUP",
        .child = "CHILD",
        .single = "SINGLE",
        .arn = "ARN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .group => "GROUP",
            .child => "CHILD",
            .single => "SINGLE",
            .arn => "ARN",
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
