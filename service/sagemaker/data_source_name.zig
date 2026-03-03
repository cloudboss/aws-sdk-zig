const std = @import("std");

pub const DataSourceName = enum {
    salesforce_genie,
    snowflake,

    pub const json_field_names = .{
        .salesforce_genie = "SalesforceGenie",
        .snowflake = "Snowflake",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .salesforce_genie => "SalesforceGenie",
            .snowflake => "Snowflake",
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
