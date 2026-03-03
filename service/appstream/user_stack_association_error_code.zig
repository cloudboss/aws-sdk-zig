const std = @import("std");

pub const UserStackAssociationErrorCode = enum {
    stack_not_found,
    user_name_not_found,
    directory_not_found,
    internal_error,

    pub const json_field_names = .{
        .stack_not_found = "STACK_NOT_FOUND",
        .user_name_not_found = "USER_NAME_NOT_FOUND",
        .directory_not_found = "DIRECTORY_NOT_FOUND",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stack_not_found => "STACK_NOT_FOUND",
            .user_name_not_found => "USER_NAME_NOT_FOUND",
            .directory_not_found => "DIRECTORY_NOT_FOUND",
            .internal_error => "INTERNAL_ERROR",
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
