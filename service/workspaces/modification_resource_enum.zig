const std = @import("std");

pub const ModificationResourceEnum = enum {
    root_volume,
    user_volume,
    compute_type,
    protocol,
    nested_virtualization,

    pub const json_field_names = .{
        .root_volume = "ROOT_VOLUME",
        .user_volume = "USER_VOLUME",
        .compute_type = "COMPUTE_TYPE",
        .protocol = "PROTOCOL",
        .nested_virtualization = "NESTED_VIRTUALIZATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .root_volume => "ROOT_VOLUME",
            .user_volume => "USER_VOLUME",
            .compute_type => "COMPUTE_TYPE",
            .protocol => "PROTOCOL",
            .nested_virtualization => "NESTED_VIRTUALIZATION",
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
