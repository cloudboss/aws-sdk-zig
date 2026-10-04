const std = @import("std");

pub const FormDataSourceType = enum {
    /// Will use a provided Amplify DataStore enabled API
    datastore,
    /// Will use passed in hooks to use when creating a form from scratch
    custom,

    pub const json_field_names = .{
        .datastore = "DataStore",
        .custom = "Custom",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .datastore => "DataStore",
            .custom => "Custom",
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
