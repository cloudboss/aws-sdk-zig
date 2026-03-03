const std = @import("std");

pub const UpdateSolNetworkType = enum {
    modify_vnf_information,
    update_ns,

    pub const json_field_names = .{
        .modify_vnf_information = "MODIFY_VNF_INFORMATION",
        .update_ns = "UPDATE_NS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .modify_vnf_information => "MODIFY_VNF_INFORMATION",
            .update_ns => "UPDATE_NS",
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
