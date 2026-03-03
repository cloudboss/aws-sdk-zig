const std = @import("std");

pub const VpcEndpointStatus = enum {
    /// Pending VPCEndpoint resource
    pending,
    /// Deleting VPCEndpoint resource
    deleting,
    /// VPCEndpoint resource is ready to use
    active,
    /// VPCEndpoint resource create or delete failed
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .deleting => "DELETING",
            .active => "ACTIVE",
            .failed => "FAILED",
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
