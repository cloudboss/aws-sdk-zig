const std = @import("std");

pub const AccessorNetworkType = enum {
    ethereum_goerli,
    ethereum_mainnet,
    ethereum_mainnet_and_goerli,
    polygon_mainnet,
    polygon_mumbai,

    pub const json_field_names = .{
        .ethereum_goerli = "ETHEREUM_GOERLI",
        .ethereum_mainnet = "ETHEREUM_MAINNET",
        .ethereum_mainnet_and_goerli = "ETHEREUM_MAINNET_AND_GOERLI",
        .polygon_mainnet = "POLYGON_MAINNET",
        .polygon_mumbai = "POLYGON_MUMBAI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ethereum_goerli => "ETHEREUM_GOERLI",
            .ethereum_mainnet => "ETHEREUM_MAINNET",
            .ethereum_mainnet_and_goerli => "ETHEREUM_MAINNET_AND_GOERLI",
            .polygon_mainnet => "POLYGON_MAINNET",
            .polygon_mumbai => "POLYGON_MUMBAI",
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
