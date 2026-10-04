const std = @import("std");

/// Optional. When you request a list of job templates, you can choose to list
/// them alphabetically by NAME or chronologically by CREATION_DATE. If you
/// don't specify, the service will list them by name.
pub const JobTemplateListBy = enum {
    name,
    creation_date,
    system,

    pub const json_field_names = .{
        .name = "NAME",
        .creation_date = "CREATION_DATE",
        .system = "SYSTEM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .creation_date => "CREATION_DATE",
            .system => "SYSTEM",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
