const std = @import("std");

pub const SecurityRequirementArtifactFormat = enum {
    md,
    pdf,
    txt,
    docx,
    doc,

    pub const json_field_names = .{
        .md = "MD",
        .pdf = "PDF",
        .txt = "TXT",
        .docx = "DOCX",
        .doc = "DOC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .md => "MD",
            .pdf => "PDF",
            .txt => "TXT",
            .docx => "DOCX",
            .doc => "DOC",
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
