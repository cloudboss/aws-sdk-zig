const std = @import("std");

pub const ArchiveStringEmailAttribute = enum {
    to,
    from,
    cc,
    subject,
    envelope_to,
    envelope_from,

    pub const json_field_names = .{
        .to = "TO",
        .from = "FROM",
        .cc = "CC",
        .subject = "SUBJECT",
        .envelope_to = "ENVELOPE_TO",
        .envelope_from = "ENVELOPE_FROM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .to => "TO",
            .from => "FROM",
            .cc => "CC",
            .subject => "SUBJECT",
            .envelope_to => "ENVELOPE_TO",
            .envelope_from => "ENVELOPE_FROM",
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
