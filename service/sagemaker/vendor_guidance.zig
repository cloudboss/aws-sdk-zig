const std = @import("std");

pub const VendorGuidance = enum {
    not_provided,
    stable,
    to_be_archived,
    archived,

    pub const json_field_names = .{
        .not_provided = "NOT_PROVIDED",
        .stable = "STABLE",
        .to_be_archived = "TO_BE_ARCHIVED",
        .archived = "ARCHIVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_provided => "NOT_PROVIDED",
            .stable => "STABLE",
            .to_be_archived => "TO_BE_ARCHIVED",
            .archived => "ARCHIVED",
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
