const std = @import("std");

pub const AcceleratorManufacturer = enum {
    amazon_web_services,
    amd,
    nvidia,
    xilinx,
    habana,

    pub const json_field_names = .{
        .amazon_web_services = "amazon-web-services",
        .amd = "amd",
        .nvidia = "nvidia",
        .xilinx = "xilinx",
        .habana = "habana",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amazon_web_services => "amazon-web-services",
            .amd => "amd",
            .nvidia => "nvidia",
            .xilinx => "xilinx",
            .habana => "habana",
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
