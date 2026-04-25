const std = @import("std");

pub const CodeGenerationOutputFormatType = enum {
    cdk_l1,
    cdk_l2,
    terraform,
    lza,

    pub const json_field_names = .{
        .cdk_l1 = "CDK_L1",
        .cdk_l2 = "CDK_L2",
        .terraform = "TERRAFORM",
        .lza = "LZA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cdk_l1 => "CDK_L1",
            .cdk_l2 => "CDK_L2",
            .terraform => "TERRAFORM",
            .lza => "LZA",
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
