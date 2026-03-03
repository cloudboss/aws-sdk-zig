const std = @import("std");

/// Describes whether the current job is running with accelerated transcoding.
/// For jobs that have Acceleration (AccelerationMode) set to DISABLED,
/// AccelerationStatus is always NOT_APPLICABLE. For jobs that have Acceleration
/// (AccelerationMode) set to ENABLED or PREFERRED, AccelerationStatus is one of
/// the other states. AccelerationStatus is IN_PROGRESS initially, while the
/// service determines whether the input files and job settings are compatible
/// with accelerated transcoding. If they are, AcclerationStatus is ACCELERATED.
/// If your input files and job settings aren't compatible with accelerated
/// transcoding, the service either fails your job or runs it without
/// accelerated transcoding, depending on how you set Acceleration
/// (AccelerationMode). When the service runs your job without accelerated
/// transcoding, AccelerationStatus is NOT_ACCELERATED.
pub const AccelerationStatus = enum {
    not_applicable,
    in_progress,
    accelerated,
    not_accelerated,

    pub const json_field_names = .{
        .not_applicable = "NOT_APPLICABLE",
        .in_progress = "IN_PROGRESS",
        .accelerated = "ACCELERATED",
        .not_accelerated = "NOT_ACCELERATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_applicable => "NOT_APPLICABLE",
            .in_progress => "IN_PROGRESS",
            .accelerated => "ACCELERATED",
            .not_accelerated => "NOT_ACCELERATED",
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
