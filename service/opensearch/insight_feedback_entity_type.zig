const std = @import("std");

/// The type of entity for which to submit insight feedback. Possible values are
/// `DomainName`.
pub const InsightFeedbackEntityType = enum {
    domain,

    pub const json_field_names = .{
        .domain = "DomainName",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .domain => "DomainName",
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
