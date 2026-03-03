const std = @import("std");

pub const ListEventTypesFilterName = enum {
    resource_type,
    service_name,

    pub const json_field_names = .{
        .resource_type = "RESOURCE_TYPE",
        .service_name = "SERVICE_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_type => "RESOURCE_TYPE",
            .service_name => "SERVICE_NAME",
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
