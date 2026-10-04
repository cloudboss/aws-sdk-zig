const std = @import("std");

pub const RecommendationSource = enum {
    trusted_advisor,
    cost_explorer,
    cloudwatch,
    well_architected_tool,
    well_architected_agent,
    customer_iac,

    pub const json_field_names = .{
        .trusted_advisor = "TRUSTED_ADVISOR",
        .cost_explorer = "COST_EXPLORER",
        .cloudwatch = "CLOUDWATCH",
        .well_architected_tool = "WELL_ARCHITECTED_TOOL",
        .well_architected_agent = "WELL_ARCHITECTED_AGENT",
        .customer_iac = "CUSTOMER_IAC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .trusted_advisor => "TRUSTED_ADVISOR",
            .cost_explorer => "COST_EXPLORER",
            .cloudwatch => "CLOUDWATCH",
            .well_architected_tool => "WELL_ARCHITECTED_TOOL",
            .well_architected_agent => "WELL_ARCHITECTED_AGENT",
            .customer_iac => "CUSTOMER_IAC",
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
