const std = @import("std");

pub const DescribeIntegrationsFilterName = enum {
    integration_arn,
    source_arn,
    source_types,
    status,

    pub const json_field_names = .{
        .integration_arn = "integration-arn",
        .source_arn = "source-arn",
        .source_types = "source-types",
        .status = "status",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .integration_arn => "integration-arn",
            .source_arn => "source-arn",
            .source_types => "source-types",
            .status => "status",
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
