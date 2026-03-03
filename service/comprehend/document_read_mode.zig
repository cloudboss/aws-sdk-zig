const std = @import("std");

pub const DocumentReadMode = enum {
    service_default,
    force_document_read_action,

    pub const json_field_names = .{
        .service_default = "SERVICE_DEFAULT",
        .force_document_read_action = "FORCE_DOCUMENT_READ_ACTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_default => "SERVICE_DEFAULT",
            .force_document_read_action => "FORCE_DOCUMENT_READ_ACTION",
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
