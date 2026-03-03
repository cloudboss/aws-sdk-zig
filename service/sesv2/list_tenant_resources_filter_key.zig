const std = @import("std");

/// The key used to filter tenant resources. Currently, the only supported
/// filter key is `RESOURCE_TYPE`.
pub const ListTenantResourcesFilterKey = enum {
    resource_type,

    pub const json_field_names = .{
        .resource_type = "RESOURCE_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_type => "RESOURCE_TYPE",
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
