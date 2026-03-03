const std = @import("std");

/// The type of reputation entity. Currently, only `RESOURCE` type entities are
/// supported,
/// which represent resources in your Amazon SES account that have reputation
/// tracking capabilities.
pub const ReputationEntityType = enum {
    resource,

    pub const json_field_names = .{
        .resource = "RESOURCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource => "RESOURCE",
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
