const std = @import("std");

/// The destination of the import job, which can be used to list import jobs
/// that have a
/// certain `ImportDestinationType`.
pub const ImportDestinationType = enum {
    suppression_list,
    contact_list,

    pub const json_field_names = .{
        .suppression_list = "SUPPRESSION_LIST",
        .contact_list = "CONTACT_LIST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .suppression_list => "SUPPRESSION_LIST",
            .contact_list => "CONTACT_LIST",
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
