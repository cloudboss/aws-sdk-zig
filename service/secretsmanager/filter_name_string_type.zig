const std = @import("std");

pub const FilterNameStringType = enum {
    description,
    name,
    tag_key,
    tag_value,
    primary_region,
    owning_service,
    all,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .tag_key = "tag-key",
        .tag_value = "tag-value",
        .primary_region = "primary-region",
        .owning_service = "owning-service",
        .all = "all",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .description => "description",
            .name => "name",
            .tag_key => "tag-key",
            .tag_value => "tag-value",
            .primary_region => "primary-region",
            .owning_service => "owning-service",
            .all => "all",
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
