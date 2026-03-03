const std = @import("std");

pub const ConnectorStatusReason = enum {
    internal_failure,
    privateca_access_denied,
    privateca_invalid_state,
    privateca_resource_not_found,

    pub const json_field_names = .{
        .internal_failure = "INTERNAL_FAILURE",
        .privateca_access_denied = "PRIVATECA_ACCESS_DENIED",
        .privateca_invalid_state = "PRIVATECA_INVALID_STATE",
        .privateca_resource_not_found = "PRIVATECA_RESOURCE_NOT_FOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_failure => "INTERNAL_FAILURE",
            .privateca_access_denied => "PRIVATECA_ACCESS_DENIED",
            .privateca_invalid_state => "PRIVATECA_INVALID_STATE",
            .privateca_resource_not_found => "PRIVATECA_RESOURCE_NOT_FOUND",
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
