const std = @import("std");

pub const ResourceCategory = enum {
    compute,
    database,
    storage,
    code,
    ai_ml,
    identity,
    network,
    other,

    pub const json_field_names = .{
        .compute = "Compute",
        .database = "Database",
        .storage = "Storage",
        .code = "Code",
        .ai_ml = "AI/ML",
        .identity = "Identity",
        .network = "Network",
        .other = "Other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .compute => "Compute",
            .database => "Database",
            .storage => "Storage",
            .code => "Code",
            .ai_ml => "AI/ML",
            .identity => "Identity",
            .network => "Network",
            .other => "Other",
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
