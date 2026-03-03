const std = @import("std");

pub const AcceleratorManufacturer = enum {
    nvidia,
    amd,
    amazon_web_services,
    xilinx,

    pub const json_field_names = .{
        .nvidia = "nvidia",
        .amd = "amd",
        .amazon_web_services = "amazon-web-services",
        .xilinx = "xilinx",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nvidia => "nvidia",
            .amd => "amd",
            .amazon_web_services => "amazon-web-services",
            .xilinx => "xilinx",
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
