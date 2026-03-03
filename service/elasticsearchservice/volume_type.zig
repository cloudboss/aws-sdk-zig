const std = @import("std");

/// The type of EBS volume, standard, gp2, gp3 or io1. See [Configuring
/// EBS-based
/// Storage](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-ebs)for more information.
pub const VolumeType = enum {
    standard,
    gp_2,
    io_1,
    gp_3,

    pub const json_field_names = .{
        .standard = "standard",
        .gp_2 = "gp2",
        .io_1 = "io1",
        .gp_3 = "gp3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "standard",
            .gp_2 => "gp2",
            .io_1 => "io1",
            .gp_3 => "gp3",
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
