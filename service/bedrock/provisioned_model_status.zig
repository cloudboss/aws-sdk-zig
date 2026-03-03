const std = @import("std");

pub const ProvisionedModelStatus = enum {
    creating,
    in_service,
    updating,
    failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .in_service = "InService",
        .updating = "Updating",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .in_service => "InService",
            .updating => "Updating",
            .failed => "Failed",
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
