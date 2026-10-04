const std = @import("std");

/// Specifies how to apply changes to the S3 bucket exclusion list defined by
/// the classification scope for an Amazon Macie account. Valid values are:
pub const ClassificationScopeUpdateOperation = enum {
    add,
    replace,
    remove,

    pub const json_field_names = .{
        .add = "ADD",
        .replace = "REPLACE",
        .remove = "REMOVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add => "ADD",
            .replace => "REPLACE",
            .remove => "REMOVE",
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
