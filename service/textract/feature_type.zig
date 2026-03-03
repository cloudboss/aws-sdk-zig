const std = @import("std");

pub const FeatureType = enum {
    tables,
    forms,
    queries,
    signatures,
    layout,

    pub const json_field_names = .{
        .tables = "TABLES",
        .forms = "FORMS",
        .queries = "QUERIES",
        .signatures = "SIGNATURES",
        .layout = "LAYOUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tables => "TABLES",
            .forms => "FORMS",
            .queries => "QUERIES",
            .signatures => "SIGNATURES",
            .layout => "LAYOUT",
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
