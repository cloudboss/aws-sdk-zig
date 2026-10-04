const std = @import("std");

pub const OcsfMapField = enum {
    resources_tags,
    compliance_control_parameters,
    databucket_tags,
    finding_info_tags,

    pub const json_field_names = .{
        .resources_tags = "resources.tags",
        .compliance_control_parameters = "compliance.control_parameters",
        .databucket_tags = "databucket.tags",
        .finding_info_tags = "finding_info.tags",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resources_tags => "resources.tags",
            .compliance_control_parameters => "compliance.control_parameters",
            .databucket_tags => "databucket.tags",
            .finding_info_tags => "finding_info.tags",
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
