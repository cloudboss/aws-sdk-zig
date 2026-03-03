const std = @import("std");

/// Specify whether the service runs your job with accelerated transcoding.
/// Choose DISABLED if you don't want accelerated transcoding. Choose ENABLED if
/// you want your job to run with accelerated transcoding and to fail if your
/// input files or your job settings aren't compatible with accelerated
/// transcoding. Choose PREFERRED if you want your job to run with accelerated
/// transcoding if the job is compatible with the feature and to run at standard
/// speed if it's not.
pub const AccelerationMode = enum {
    disabled,
    enabled,
    preferred,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .preferred = "PREFERRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .enabled => "ENABLED",
            .preferred => "PREFERRED",
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
