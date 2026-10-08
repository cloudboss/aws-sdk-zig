const std = @import("std");

pub const InputSourceType = enum {
    cfn_stack,
    tags,
    eks,
    terraform,
    design_file,
    monitoring,

    pub const json_field_names = .{
        .cfn_stack = "CFN_STACK",
        .tags = "TAGS",
        .eks = "EKS",
        .terraform = "TERRAFORM",
        .design_file = "DESIGN_FILE",
        .monitoring = "MONITORING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cfn_stack => "CFN_STACK",
            .tags => "TAGS",
            .eks => "EKS",
            .terraform => "TERRAFORM",
            .design_file => "DESIGN_FILE",
            .monitoring => "MONITORING",
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
