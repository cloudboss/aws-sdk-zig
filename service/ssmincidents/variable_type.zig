const std = @import("std");

pub const VariableType = enum {
    incident_record_arn,
    involved_resources,

    pub const json_field_names = .{
        .incident_record_arn = "INCIDENT_RECORD_ARN",
        .involved_resources = "INVOLVED_RESOURCES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .incident_record_arn => "INCIDENT_RECORD_ARN",
            .involved_resources => "INVOLVED_RESOURCES",
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
