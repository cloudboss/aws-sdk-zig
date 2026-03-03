const std = @import("std");

pub const ClusterStatus = enum {
    creating,
    deleting,
    failed,
    inservice,
    rollingback,
    systemupdating,
    updating,

    pub const json_field_names = .{
        .creating = "Creating",
        .deleting = "Deleting",
        .failed = "Failed",
        .inservice = "InService",
        .rollingback = "RollingBack",
        .systemupdating = "SystemUpdating",
        .updating = "Updating",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .deleting => "Deleting",
            .failed => "Failed",
            .inservice => "InService",
            .rollingback => "RollingBack",
            .systemupdating => "SystemUpdating",
            .updating => "Updating",
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
