const std = @import("std");

/// The type of Lambda compute resource that can use a network connector.
pub const ComputeResourceType = enum {
    /// MicroVm compute resource type
    micro_vm,
    /// WebFunction compute resource type
    web_function,

    pub const json_field_names = .{
        .micro_vm = "MicroVm",
        .web_function = "WebFunction",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .micro_vm => "MicroVm",
            .web_function => "WebFunction",
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
